 require 'spec_helper'
feature 'user visit the wedding party index ' do
  scenario 'A logged in user can visit the Wedding Party page' do
    create_and_login_user
    click_link 'Wedding Party'

    expect(page).to have_content 'Groomsmen'
    expect(page).to have_content 'Bridesmaids'
  end
end