require 'spec_helper'

feature 'user can login ' do
  before do
    @user = User.create!(email: 'evan@example.com', password: 'password', name:'Evan Tedesco', admin: true)
  end

  scenario 'user can login with email and password' do
    visit '/sessions/new'
    fill_in 'user[email]', with: 'evan@example.com'
    fill_in 'user[password]', with: 'password'
    click_button 'Login'
    expect(page).to have_content 'Welcome Evan Tedesco'
    click_on 'Logout'
    expect(page).to have_content 'Login'
  end

  scenario 'User cannot login with incorrect password' do
    visit '/sessions/new'
    fill_in 'user[email]', with: 'evan@example.com'
    fill_in 'user[password]', with: 'wrong password'
    click_button 'Login'
    expect(page).to have_content 'Incorrect Email or Password'
  end

end



