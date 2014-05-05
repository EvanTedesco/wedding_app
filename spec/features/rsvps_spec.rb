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
    visit'/rsvps'
    expect(page).to have_content'Your mom'

  end

  scenario 'It renders an error if required field is blank'do
    visit '/'
    click_on 'RSVP'
    fill_in '*Full Name', with: ''
    fill_in '*Email', with: ''
    click_button 'submit'
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Attending is not included in the list"
  end

  scenario 'A gif is displayed depending on attending choice'do
    visit '/'
    click_on 'RSVP'
    fill_in '*Full Name', with: 'Your mom'
    fill_in '*Email', with: 'mom@example.com'
    choose'rsvp_attending_true'
    click_button 'submit'
    expect(page).to have_content "Let's Party Down!"
    click_on 'RSVP'
    fill_in '*Full Name', with: 'Your mom'
    fill_in '*Email', with: 'mom@example.com'
    choose'rsvp_attending_false'
    click_button 'submit'
    expect(page).to have_content "Whack Attack!"

  end
end