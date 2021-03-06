require 'spec_helper'

feature 'Rsvp manager' do
  context 'The user logs in' do
    before do
      @food = create_food
      @user = create_and_login_user(max_guests: 3)
      click_link 'RSVP'
    end

    scenario 'A user can only RSVP once' do

      choose 'rsvp_attending_true'
      page.select @food.name, :from => 'rsvp_user_food_id'
      click_button 'Submit'
      click_link 'RSVP'

      expect(page).to have_content 'A RSVP already exists for you'
    end


    scenario 'A gif is displayed when user is attending' do

      choose 'rsvp_attending_true'
      page.select @food.name, :from => 'rsvp_user_food_id'
      select '1', from: 'rsvp_number_of_guests'
      click_button 'Submit'

      expect(page).to have_content 'Let\'s Party Down!'
    end

    scenario 'A gif is displayed when user is not attending' do
      choose 'rsvp_attending_false'
      click_button 'Submit'

      expect(page).to have_content 'Whack Attack!'
    end

    scenario 'A user can make a meal choice' do

      choose 'rsvp_attending_true'
      page.select @food.name, :from => 'rsvp_user_food_id'
      click_button 'Submit'

      expect(page).to have_no_content 'You\'re invited to come celebrate with us!'
      expect(page).to have_content 'Let\'s Party Down!'
    end

    scenario 'A user can create a guest with a meal choice' do
      choose 'rsvp_attending_true'
      page.select @food.name, :from => 'rsvp_user_food_id'
      fill_in 'guest_0_name', with: 'Guest1'
      page.select @food.name, :from => 'guest_0_food_id'
      fill_in 'guest_1_name', with: 'Guest2'
      page.select @food.name, :from => 'guest_1_food_id'
      click_button 'Submit'

      expect(Guest.all.length).to eq(2)
      expect(Guest.last.name).to eq('Guest2')
      expect(Guest.last.food_id).to eq(@food.id)
    end

    scenario 'Guests of a user are not saved if user is not attending' do

      choose 'rsvp_attending_true'
      page.select @food.name, :from => 'rsvp_user_food_id'
      fill_in 'guest_0_name', with: 'Guest1'
      page.select @food.name, :from => 'guest_0_food_id'
      fill_in 'guest_1_name', with: 'Guest2'
      page.select @food.name, :from => 'guest_1_food_id'
      choose 'rsvp_attending_false'
      click_button 'Submit'

      expect(Guest.all.length).to eq(0)
    end

    scenario 'Guests are not saved if user changes mind', js: true do
        choose 'rsvp_attending_true'
        select '3', from: 'rsvp_number_of_guests'
        page.select @food.name, :from => 'rsvp_user_food_id'
        fill_in 'guest_0_name', with: 'Guest1'
        page.select @food.name, :from => 'guest_0_food_id'
        fill_in 'guest_1_name', with: 'Guest2'
        page.select @food.name, :from => 'guest_1_food_id'
        fill_in 'guest_2_name', with: 'Guest3'
        page.select @food.name, :from => 'guest_1_food_id'
        select '2', from: 'rsvp_number_of_guests'
        sleep(2)
        click_button 'Submit'

        expect(Guest.all.length).to eq(2)
    end

    scenario 'Guest is prompted with error if attending is not chosen' do
      click_button 'Submit'
      expect(page).to have_content 'You must accept or decline'

      expect(page).to have_no_content 'Attending'
    end
  end

  context 'The user is not logged in' do
    scenario 'User cannot rsvp unless logged in' do

      visit '/'
      click_link 'RSVP'

      expect(page).to have_content 'You must be logged in to see this page'
    end
  end
end