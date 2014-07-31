require 'spec_helper'

feature 'The deets' do
  scenario 'The deets page is displayed when the link is clicked' do
    new_time = '2014-07-11T21:53:58Z'
    Timecop.freeze(new_time) do
      VCR.use_cassette('features/deets') do
        user = create_user

        visit '/sessions/new'
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Login'
        click_link 'The Deets'
        click_link 'Check hotel pricing and availability'

        expect(page).to have_content 'Enter reservation details below'

        fill_in 'arrival_date', with: '6/12/2015'
        fill_in 'departure_date', with: '6/15/2015'
        click_on 'Get pricing'

      end
    end
  end
end