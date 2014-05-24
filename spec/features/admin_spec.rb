require 'spec_helper'

describe 'Admin options'do
  before do
    @admin_password = 'admin'
    @admin_user = create_admin(@admin_password)
  end

  it 'Admin can view all RSVPS'do
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_password
    click_button 'Login'
    click_on 'Admin'
    click_on 'All RSVPS'
    expect(page).to have_content'RSVP list'
  end
end