require 'spec_helper'

feature 'Admin options'do
  before do
    @admin_password = 'admin'
    @admin_user = create_admin(@admin_password)
  end

  scenario 'Admin can view all RSVPS'do
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_password
    click_button 'Login'
    click_on 'Admin'
    click_on 'All RSVPS'
    expect(page).to have_content'RSVP list'
  end

  scenario 'An admin can create users'do
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_password
    click_button 'Login'
    click_on 'Admin'
    click_on 'Create user'
    fill_in 'user[name]', with: 'new user'
    fill_in 'user[email]', with: 'jeff@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[max_guests]', with: 1
    click_on 'Create user'
    expect(page).to have_content 'new user has been sent an invitation'

  end

  scenario 'An admin can add food choices' do
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_password
    click_button 'Login'
    click_on 'Admin'
    click_on 'Menu options'
    click_on 'Add food item'
    fill_in 'food_name', with: 'Steak'
    fill_in 'food_description', with: 'Savory steak is savory'
    click_on 'Add food'
    expect(page).to have_content 'Steak'
    expect(page).to have_content 'Menu Options'

  end
end