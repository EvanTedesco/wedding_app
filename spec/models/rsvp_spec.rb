require 'spec_helper'

describe "Rsvp" do
  before do
    DatabaseCleaner.clean
  end

  subject { Rsvp.new }
  it_behaves_like "ActiveModel"
  context "validations" do
    context "when user is not attending" do
      let(:user) { create_user(max_guests: 3) }
      let(:rsvp_attributes) { {user: user, attending: "false"} }

      it "doesn't validate number of guests" do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: 4))
        expect(rsvp).to be_valid
      end

      it "doesn't validate positive number of guests" do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: -1))
        expect(rsvp).to be_valid
      end

      it "doesn't validate nummericality of guests" do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: "Blue"))
        expect(rsvp).to be_valid
      end

    end

    context "when user is attending" do
      let(:user) { create_user(max_guests: 3) }
      let(:rsvp_attributes) { {user: user, attending: "true"} }

      it "should validate number of guests" do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: 4))
        expect(rsvp).to be_invalid
      end

      it "should validate number of guests" do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: 3))
        expect(rsvp).to be_valid
      end

      it "should validate positive number of guests" do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: -1))
        expect(rsvp).to be_invalid
      end

      it "should validate nummericality of guests" do
        rsvp = Rsvp.new(rsvp_attributes.merge(number_of_guests: "Blue"))
        expect(rsvp).to be_invalid
      end
    end

    context "Attending formatting" do 
    let(:user) {create_user}

    it "should not allow wierd string value for attending" do
      rsvp = Rsvp.new(user: user, attending: "maybe")
      expect(rsvp).to be_invalid
    end

    it "should not allow nil value for attending" do
      rsvp = Rsvp.new(user: user, attending: nil)
      expect(rsvp).to be_invalid
    end

    it "should validate true value for attending" do
      rsvp = Rsvp.new(user: user, attending: "true", number_of_guests: 0)
      expect(rsvp).to be_valid
    end

    it "should validate false value for attending" do
      rsvp = Rsvp.new(user: user, attending: "false")
      expect(rsvp).to be_valid
    end
  end
end

context "attending" do
  let(:user) { create_user }
  it "should return true when attending is true" do
    rsvp = Rsvp.new(user: user, attending: "true")
    expect(rsvp.attending).to be_true
  end

  it "should return false when attending is false" do
    rsvp = Rsvp.new(user: user, attending: "false")
    expect(rsvp.attending).to be_false
  end

  it "should return nil when attending is maybe" do
    rsvp = Rsvp.new(user: user, attending: "maybe")
    expect(rsvp.attending).to be_nil
  end
end
end