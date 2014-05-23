require 'spec_helper'

feature 'Rsvp manager' do

  before do
    @admin_password = 'admin'
    @admin_user = create_admin(@admin_password)
  end

  scenario 'A gif is displayed depending on attending choice' do

    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_password
    click_button 'Login'
    click_on 'RSVP'
    choose 'rsvp_attending_true'
    click_button 'submit'
    expect(page).to have_content "Let's Party Down!"
    click_on 'RSVP'
    choose 'rsvp_attending_false'
    click_button 'submit'
    expect(page).to have_content "Whack Attack!"
  end
end