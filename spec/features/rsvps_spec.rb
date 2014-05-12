require 'spec_helper'

feature 'Rsvp manager' do
  scenario 'It allows guests to RSVP with a password' do
    visit '/login/new'
    # log in
    fill_in 'Email address', with: 'Joe@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    click_on 'RSVP'
    fill_in '*Full Name', with: 'Your mom'
    fill_in '*Email', with: 'mom@example.com'
    choose 'rsvp_attending_true'
    click_button 'submit'
    expect(page).to have_content 'Login'
    visit '/rsvps'
    expect(page).to have_content 'Your mom'
  end

  scenario 'It prevents guests from RSVPing without a password' do
    visit '/login/new'
    # log in
    fill_in 'password', with: 'wrong_password'
    click_button 'Sign In'

    expect(page).to have_no_link('RSVP')
  end



  scenario 'A gif is displayed depending on attending choice' do

    visit '/login/new'
    fill_in 'password', with: 'password'
    click_button 'Sign In'
    click_on 'RSVP'
    fill_in '*Full Name', with: 'Your mom'
    fill_in '*Email', with: 'mom@example.com'
    choose 'rsvp_attending_true'
    click_button 'submit'
    expect(page).to have_content "Let's Party Down!"
    click_on 'RSVP'
    fill_in '*Full Name', with: 'Your mom'
    fill_in '*Email', with: 'mom@example.com'
    choose 'rsvp_attending_false'
    click_button 'submit'
    expect(page).to have_content "Whack Attack!"
  end
end