require 'spec_helper'

feature 'Rsvp manager' do

  before do
    DatabaseCleaner.clean
    @admin_password = 'password'
    @admin_user = create_admin(@admin_password)
    @user_password = 'password'
    @user = create_user(@user_password)
    create_food
  end

  scenario 'A user can only RSVP once' do
    visit '/sessions/new'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user_password
    click_button 'Login'
    click_on 'RSVP'
    choose 'rsvp_attending_true'
    page.select 'Steak', :from => 'rsvp_user_food_id'
    click_button 'submit'
    click_on 'RSVP'
    expect(page).to have_content 'A RSVP already exists for you'
  end


  scenario 'A gif is displayed when user is attending' do

    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_password
    click_button 'Login'
    click_on 'RSVP'
    choose 'rsvp_attending_true'
    page.select 'Steak', :from => 'rsvp_user_food_id'
    select '1', from:'rsvp_number_of_guests'
    click_button 'submit'
    expect(page).to have_content "Let's Party Down!"
  end

  scenario 'A gif is displayed when user is not attending' do
    visit '/sessions/new'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user_password
    click_button 'Login'
    click_on 'RSVP'
    choose 'rsvp_attending_false'
    click_button 'submit'
    expect(page).to have_content "Whack Attack!"
  end

  scenario 'A user can make a meal choice' do
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_password
    click_button 'Login'
    click_on 'RSVP'
    choose 'rsvp_attending_true'
    page.select 'Steak', :from => 'rsvp_user_food_id'
    click_button 'submit'
    expect(page).to have_no_content "You're invited to come celebrate with us! "
    expect(page).to have_content "Let's Party Down!"
  end

  scenario 'A user can create a guest with a meal choice' do
    user =   User.create!(email: 'bob2@example.com', password: 'password', name:'Bob Smith', max_guests:2, admin: false)

    visit '/sessions/new'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'
    click_button 'Login'
    click_on 'RSVP'
    choose 'rsvp_attending_true'
    page.select 'Steak', :from => 'rsvp_user_food_id'
    fill_in 'guest_0_name', with: 'Guest1'
    page.select 'Steak', :from => 'guest_0_food_id'
    fill_in 'guest_1_name', with: 'Guest2'
    page.select 'Steak', :from => 'guest_1_food_id'

    click_on 'submit'
    expect(Guest.all.length).to eq(2)
  end

end