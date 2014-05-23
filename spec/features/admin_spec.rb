# require 'spec_helper'
#
# describe 'Admin options'do
#   it 'Admin can view all RSVPS'do
#     visit '/sessions/new'
#     fill_in 'user[email]', with: 'Admin@admin.com'
#     fill_in 'user[password]', with: ENV['ADMIN']
#     click_button 'Login'
#     click_on 'Admin'
#     click_on 'All RSVPS'
#     expect(page).to have_content'RSVP list'
#   end
# end