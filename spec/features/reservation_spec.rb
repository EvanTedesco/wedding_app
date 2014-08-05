require 'spec_helper'
feature 'reservation manager' do
  scenario 'a non-user cannot check availability' do
    visit new_reservation_path

    expect(page).to have_content 'You must be logged in to see this page'

    visit reservations_path

    expect(page).to have_content 'You must be logged in to see this page'
  end
end