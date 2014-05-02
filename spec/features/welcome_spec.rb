require 'spec_helper'

feature 'Welcome Page' do
  scenario 'It shows a welcome page' do
    visit '/'
    click_on 'Register'
    fill_in 'email', with: 'Joe@example.com'
    fill_in 'password', with: 'password'
    fill_in 'password_confirm', with: 'password'
    click_on 'Register'
    expect(page).to have_content 'RSVP'

  end
end