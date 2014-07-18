require 'spec_helper'

feature 'user can login ' do
before do
   @admin_user = create_admin
   @user = create_user
end

scenario 'user can login with email and password and logout' do

  visit '/sessions/new'
   fill_in 'user[email]', with: @admin_user.email
   fill_in 'user[password]', with: @admin_user.password
   click_button 'Login'

   expect(page).to have_content 'Welcome Evan Tedesco'

   click_link 'Logout'

   expect(page).to have_content 'Login'
end

scenario 'User cannot login with incorrect password' do

   visit '/sessions/new'
   fill_in 'user[email]', with: @admin_user.email
   fill_in 'user[password]', with: 'wrong password'
   click_button 'Login'

   expect(page).to have_content 'Incorrect Email or Password'
end

scenario 'Admin users can see admin options on homepage and non admins cannot'do

  visit '/sessions/new'
   fill_in 'user[email]', with: @admin_user.email
   fill_in 'user[password]', with: @admin_user.password
   click_button 'Login'

   expect(page).to have_content 'Admin'

   click_link 'Logout'
   click_link 'Login'
   fill_in 'user[email]', with: @user.email
   fill_in 'user[password]', with: @user.password
   click_button 'Login'

  expect(page).to have_no_content 'Admin'
end
  scenario 'A user is redirected to target page after logging in' do

    visit '/'
    click_link 'Our Story'

    expect(page).to have_content 'You must be logged in to see this page'

    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'

    expect(page).to have_content 'Our Storybook'

    click_link 'Logout'
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'

    expect(page).to have_content 'You don\'t love someone for their looks'
  end
end



