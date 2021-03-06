require 'spec_helper'

feature 'user can login ' do
  before do
    @user = create_user
  end

  scenario 'user can login with email and password and logout' do
    create_and_login_admin

    expect(page).to have_content 'Welcome Evan Tedesco'

    click_link 'Logout'

    expect(page).to have_content 'Login'
  end

  scenario 'User cannot login with incorrect password' do

    visit '/sessions/new'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: 'wrong password'
    click_button 'Login'

    expect(page).to have_content 'Incorrect Email or Password'
  end

  scenario 'Admin users can see admin options on homepage and non admins cannot' do
    create_and_login_admin

    expect(page).to have_content 'Admin'

    click_link 'Logout'
    create_and_login_user

    expect(page).to have_no_content 'Admin'
  end
  scenario 'A user is redirected to target page after logging in' do
    user = create_user
    visit '/'
    click_link 'Our Story'

    expect(page).to have_content 'You must be logged in to see this page'

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Login'

    expect(page).to have_content 'Our Storybook'

    click_link 'Logout'
    visit '/sessions/new'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Login'

    expect(page).to have_content 'You don\'t love someone for their looks'
  end
end



