require 'spec_helper'

describe 'Rsvp' do

  subject { Rsvp.new }
  it_behaves_like 'ActiveModel'
  context 'validations' do
    context 'when user is not attending' do
      let(:user) { create_user(max_guests: 3) }
      let(:rsvp_attributes) { {user: user, attending: 'false'} }

      it 'does not validate number of guests' do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: 4))

        expect(rsvp).to be_valid
      end

      it 'does not validate positive number of guests' do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: -1))

        expect(rsvp).to be_valid
      end

      it 'does not validate nummericality of guests' do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: 'Blue'))

        expect(rsvp).to be_valid
      end

    end

    context 'when user is attending' do
      let(:user) { create_user(max_guests: 3) }
      let(:rsvp_attributes) { {user: user, attending: 'true'} }

      it 'should validate number of guests' do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: 4))

        expect(rsvp).to be_invalid
      end

      it 'should validate number of guests' do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: 3))

        expect(rsvp).to be_valid
      end

      it 'should validate positive number of guests' do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: -1))

        expect(rsvp).to be_invalid
      end

      it 'should validate nummericality of guests' do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: 'Blue'))

        expect(rsvp).to be_invalid
      end
    end

    context 'Attending formatting' do
      let(:user) { create_user }

      it 'should not allow wierd string value for attending' do
        rsvp = Rsvp.new(user: user, attending: 'maybe')

        expect(rsvp).to be_invalid
      end

      it 'should not allow nil value for attending' do
        rsvp = Rsvp.new(user: user, attending: nil)

        expect(rsvp).to be_invalid
      end

      it 'should validate true value for attending' do
        rsvp = Rsvp.new(user: user, attending: 'true', number_of_guests: 0)

        expect(rsvp).to be_valid
      end

      it 'should validate false value for attending' do
        rsvp = Rsvp.new(user: user, attending: 'false')

        expect(rsvp).to be_valid
      end
    end
  end

  context 'attending' do
    let(:user) { create_user }
    it 'should return true when attending is true' do
      rsvp = Rsvp.new(user: user, attending: 'true')

      expect(rsvp.attending).to be_true
    end

    it 'should return false when attending is false' do
      rsvp = Rsvp.new(user: user, attending: 'false')

      expect(rsvp.attending).to be_false
    end

    it 'should return nil when attending is maybe' do
      rsvp = Rsvp.new(user: user, attending: 'maybe')

      expect(rsvp.attending).to be_nil
    end
  end

  it 'determines the number of guests correctly' do
    user = create_user(max_guests: 3)
    rsvp = Rsvp.new(user: user, attending: 'true')

    expect(rsvp.guest_limit).to eq(3)
  end

  context 'save fields' do
    it 'does not save invalid rsvp' do
      rsvp = Rsvp.new({attending: 'true'})

      expect(rsvp.save_fields).to be_false
    end

    context 'when user is attending' do
      let!(:user) { create_user(max_guests: 3) }
      let(:rsvp_attributes) { {user: user, attending: 'true', number_of_guests: 2} }
      let(:guest_attributes) { {'0' => {'name' => '1', 'food_id' => '1'},
                                '1' => {'name' => '2', 'food_id' => '2'}} }
      let(:rsvp) { Rsvp.new(rsvp_attributes.merge(guests: guest_attributes)) }

      it 'does not update attributes for user with invalid guest' do
        Guest.any_instance.stub(:valid?).and_return(false)
        rsvp.save_fields

        expect(user.reload.attending).to be_nil
      end

      it 'does not create guests for rsvps with invalid attributes' do
        User.any_instance.stub(:valid?).and_return(false)
        rsvp.save_fields

        expect(user.guests.count).to eq(0)
      end

      it 'does create guests' do
        rsvp.save_fields

        expect(rsvp).to be_valid
        expect(user.guests.count).to eq(2)
      end
    end

    context 'when user is not attending' do
      let!(:user) { create_user(max_guests: 3) }
      let(:rsvp_attributes) { {user: user, attending: 'false'} }
      let(:guest_attributes) { {'0' => {'name' => '1', 'food_id' => '1'},
                                '1' => {'name' => '2', 'food_id' => '2'}} }
      let(:rsvp) { Rsvp.new(rsvp_attributes.merge(guests: guest_attributes)) }

      it 'does not create guests' do
        rsvp.save_fields

        expect(user.guests.count).to eq(0)
      end
      it 'updates attributes' do
        rsvp.save_fields

        expect(user.attending).to eq(false)
      end
    end

    context 'save_fields behaves as a predicate' do
      let!(:user) { create_user(max_guests: 3) }
      let(:rsvp_attributes) { {user: user, attending: 'true', number_of_guests: 2} }
      let(:guest_attributes) { {'0' => {'name' => '1', 'food_id' => '1'},
                                '1' => {'name' => '2', 'food_id' => '2'}} }
      let(:rsvp) { Rsvp.new(rsvp_attributes.merge(guests: guest_attributes)) }

      it 'returns true when transaction occurs' do
        expect(rsvp.save_fields).to eq(true)
      end
      it 'returns false if transaction does not occur' do
        Guest.any_instance.stub(:valid?).and_return(false)

        expect(rsvp.save_fields).to eq(false)
      end
    end
  end
end