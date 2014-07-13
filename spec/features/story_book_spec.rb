require 'spec_helper'

feature 'user visit the storybook index ' do
  before do
    DatabaseCleaner.clean
    @user = create_user
  end

  scenario 'A logged in user can visit the storybook page' do
    visit '/'
    click_link 'Login'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Login'
    click_link 'Our Story'
    expect(page).to have_content 'Our Storybook'
  end
end
