require 'spec_helper'

feature 'Rsvp manager' do
  scenario 'It allows guests to RSVP' do
    visit '/'
    expect(page).to have_content "Evan and Crystal Tedesco's Awesome Wedding Site"
    click_on 'RSVP'
    fill_in 'Name', with: 'Your mom'
    choose'rsvp_attending_true'
    choose'rsvp_guest_true'
    click_button 'RSVP'
    expect(page).to have_content'Your mom'
  end
end