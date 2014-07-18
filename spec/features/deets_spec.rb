require 'spec_helper'

feature 'The deets' do
  scenario 'The deets page is displayed when the link is clicked' do
    user = create_user

    visit '/sessions/new'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Login'
    click_link 'The Deets'

    expect(page).to have_content 'The Deets'
  end
end