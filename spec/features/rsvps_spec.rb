require 'spec_helper'

feature 'Rsvp manager' do
  scenario 'It allows guests to RSVP' do
    visit '/'
    click_on 'RSVP'
    fill_in '*Full Name', with: 'Your mom'
    fill_in '*Email', with: 'mom@example.com'
    choose'rsvp_attending_true'
    click_button 'submit'
    expect(page).to have_content'Login'
  end

  scenario 'It renders an error if required feilds are blank'do
    visit '/'
    click_on 'RSVP'
    fill_in '*Full Name', with: ''
    fill_in '*Email', with: ''
    click_button 'submit'
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Attending can't be blank"
  end
end