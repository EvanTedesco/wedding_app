 require 'spec_helper'
feature 'user visit the wedding party index ' do
  scenario 'A logged in user can visit the Wedding Party page' do
    user = create_user

    visit '/'
    click_link 'Login'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Login'
    click_link 'Wedding Party'

    expect(page).to have_content 'Groomsmen'
    expect(page).to have_content 'Bridesmaids'
  end
end