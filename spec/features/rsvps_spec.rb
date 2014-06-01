require 'spec_helper'

feature 'Rsvp manager' do

  before do
    DatabaseCleaner.clean
    @admin_password = 'admin'
    @admin_user = create_admin(@admin_password)
    @user_password = 'password'
    @user = create_user(@user_password)
  end

  scenario 'A user can only RSVP once'do
    visit '/sessions/new'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user_password
    click_button 'Login'
    click_on 'RSVP'
    choose 'rsvp_attending_true'
    fill_in 'rsvp[number_of_guests]', with:1
    click_button 'submit'
    click_on 'RSVP'
    expect(page).to have_content 'A RSVP already exists for you'
  end


  scenario 'A gif is displayed depending on attending choice' do

    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_password
    click_button 'Login'
    click_on 'RSVP'
    choose 'rsvp_attending_true'
    fill_in 'rsvp[number_of_guests]', with:1
    click_button 'submit'
    expect(page).to have_content "Let's Party Down!"
    click_on 'RSVP'
    choose 'rsvp_attending_false'
    click_button 'submit'
    expect(page).to have_content "Whack Attack!"
  end

  scenario 'A user cannot RSVP with more guests than allowed' do
    visit '/sessions/new'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user_password
    click_button 'Login'
    click_on 'RSVP'
    choose 'rsvp_attending_true'
    fill_in 'rsvp[number_of_guests]', with:5
    click_on 'submit'
    expect(page).to have_content "You're invited to come celebrate with us! "
    expect(page).to have_no_content "Let's Party Down!"

  end

  #
  #scenario 'A user can make a meal choice' do
  #  visit '/sessions/new'
  #  fill_in 'user[email]', with: @user.email
  #  fill_in 'user[password]', with: @user_password
  #  click_button 'Login'
  #  click_on 'RSVP'
  #  choose 'rsvp_attending_true'
  #  fill_in 'User[rsvps][meal_choice]', with:'steak'
  #  click_button 'submit'
  #end
end