require 'spec_helper'

feature 'The deets' do
  scenario 'The deets page is displayed when the link is clicked' do
    create_and_login_user
    click_link 'The Deets'
    click_link 'here'

    expect(page).to have_content 'Enter reservation details below'
  end

  scenario 'non-users cannot visit deets page' do
    visit '/'
    click_link 'The Deets'

    expect(page).to have_content 'You must be logged in to see this page'
  end
end