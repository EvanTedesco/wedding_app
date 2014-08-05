require 'spec_helper'
feature 'reservation manager' do
  scenario 'a non-user cannot check availability' do
    visit new_reservation_path

    expect(page).to have_content 'You must be logged in to see this page'

    visit reservations_path

    expect(page).to have_content 'You must be logged in to see this page'
  end

  scenario 'a user checks availability' do
    new_time = '2014-07-11T21:53:58Z'
    Timecop.freeze(new_time) do
      VCR.use_cassette('features/deets') do
        create_and_login_user
        visit new_reservation_path

        fill_in 'arrival_date', with: '6/12/2015'
        fill_in 'departure_date', with: '6/15/2015'
        fill_in 'number_of_rooms', with: 1
        fill_in 'number_of_adults', with: 2
        click_on 'Get pricing'

        expect(page).to have_content 'Available rooms'
      end
    end
  end
end