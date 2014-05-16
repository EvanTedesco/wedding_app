require 'spec_helper'

describe 'Admin options'do
  it 'Admin can view all RSVPS'do
    visit '/login/new'
    fill_in 'Email address', with: 'Admin@admin.com'
    fill_in 'password', with: ENV['ADMIN']
    click_on 'Sign In'
    click_on 'Admin'
    click_on 'All RSVPS'
    expect(page).to have_content'RSVP list'
  end
end