require 'spec_helper'

feature 'The deets' do
  scenario 'The deets page is displayed when the link is clicked' do
    new_time = '2014-07-11T21:53:58Z'
    Timecop.freeze(new_time) do
      VCR.use_cassette('features/deets') do
        create_and_login_user
        click_link 'The Deets'
        click_link 'here'

        expect(page).to have_content 'Enter reservation details below'

        fill_in 'arrival_date', with: '6/12/2015'
        fill_in 'departure_date', with: '6/15/2015'
        click_on 'Get pricing'

        expect(page).to have_content 'Available rooms'
      end
    end
  end

  scenario 'non-users cannot visit deets page' do
    visit '/'
    click_link 'The Deets'

    expect(page).to have_content'You must be logged in to see this page'
  end
end