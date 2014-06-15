require 'spec_helper'

describe "Rsvp" do
  subject { Rsvp.new }
  it_behaves_like "ActiveModel"

  it "is invalid if number of guests passed in is greater than the user's max guests" do
    user = create_user(max_guests: 2)
    rsvp = Rsvp.new(user_id: user.id, number_of_guests: "3", attending: "true")
    expect(rsvp).to have_at_least(1).errors_on(:number_of_guests)
  end

  it "doesn't validate number of guests if they are not attending" do
    user = create_user(max_guests: 2)
    rsvp = Rsvp.new(user_id: user.id, number_of_guests: 3, attending: "false")
    expect(rsvp).to have(0).errors_on(:number_of_guests)
  end


end