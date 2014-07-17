require 'spec_helper'

feature 'deets api call' do
  scenario 'the info is displayed when the deets page is visited' do
    user = create_user
    visit '/sessions/new'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Login'
    click_link 'The Deets'
    expect(page).to have_content 'The Deets'
  end
end