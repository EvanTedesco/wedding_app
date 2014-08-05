require 'spec_helper'

feature 'user visit the storybook index ' do

  scenario 'A logged in user can visit the storybook page' do
    create_and_login_user
    click_link 'Our Story'

    expect(page).to have_content 'Our Storybook'
  end
end
