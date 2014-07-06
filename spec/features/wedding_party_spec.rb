require 'spec_helper'
feature 'user visit the wedding party index ' do
  before do
    DatabaseCleaner.clean
    @user = create_user
  end

  scenario 'A logged in user can visit the Wedding Party page' do
    visit '/'
    click_on 'Login'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Login'
    click_on 'Wedding Party'
    expect(page).to have_content 'Groomsmen'
    expect(page).to have_content 'Bridesmaids'

  end
  end