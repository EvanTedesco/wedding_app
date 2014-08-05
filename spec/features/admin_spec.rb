require 'spec_helper'

feature 'Admin options' do
  before do
    @admin_user = create_admin
    @user = create_user
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'
  end

  scenario 'Admin can view all RSVPS' do

    click_link 'RSVPS'

    expect(page).to have_content 'RSVP List'
  end

  scenario 'An admin can create users' do
    number_of_users = User.all.length

    click_link 'Users'
    fill_in 'user[name]', with: 'new user'
    fill_in 'user[email]', with: 'jeff@example.com'
    fill_in 'user[max_guests]', with: 1
    click_button 'Create user'

    expect(page).to have_content 'new user has been sent an invitation'
    expect(User.all.length).to eq(number_of_users + 1)
  end

  scenario 'An admin can delete users' do
    number_of_users = User.all.length

    click_link 'Users'
    within("//tr[@id=#{@user.name}]") do
      click_link 'Delete'
    end

    expect(User.all.length).to eq (number_of_users - 1)
  end

  scenario 'admin cannot create users with duplicate email' do

    click_link 'Users'
    fill_in 'user[name]', with: @user.name
    fill_in 'user[email]', with: @user.email
    fill_in 'user[max_guests]', with: 1
    click_button 'Create user'

    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'Only an admin can add food choices' do

    click_link 'Menu'
    click_link 'Add food item'
    fill_in 'food_name', with: 'Steak'
    fill_in 'food_description', with: 'Savory steak is savory'
    click_button 'Add food'

    expect(page).to have_content 'Steak'
    expect(page).to have_content 'Menu Items:'

    click_link 'Logout'
    create_and_login_user
    visit '/foods/new'

    expect(page).to have_no_content 'Add a food item'

    visit '/foods'

    expect(page).to have_no_content 'Menu Options'
  end

  scenario 'Admin cannot create an invalid food item' do

    click_link 'Menu'
    click_link 'Add food item'
    fill_in 'food_name', with: 'Steak' * 60
    fill_in 'food_description', with: 'Savory steak is savory'
    click_button 'Add food'

    expect(page).to have_no_content 'Menu items:'
  end

  scenario 'Admin can delete menu item' do
    food = create_food

    click_link 'Menu'
    expect(page).to have_content 'Menu Items:'
    click_link 'Delete'

    expect(page).to have_no_content food.name
  end

  scenario 'Admin can update menu items' do
    food = create_food

    click_link 'Menu'
    click_link food.name
    fill_in 'food_name', with: 'Skirt steak'
    fill_in 'food_description', with: 'Savory skirt steak is savory'
    click_button 'Edit'

    expect(page).to have_content 'Savory skirt steak is savory'
    expect(page).to have_no_content food.name
  end

  scenario 'Admin user can see the guest names and food choice for a user' do
    food = create_food
    user = create_user(email: 'Bobby@example.com', attending: true, number_of_guests: 1, max_guests: 2)
    guest = create_guest(user_id: user.id, food_id: food.id)

    click_link 'RSVPS'
    click_link user.number_of_guests

    expect(page).to have_content user.name
    expect(page).to have_content guest.name
    expect(page).to have_content food.name
  end

  scenario 'Admin can see a list of all comments and their associated users' do
    user = create_user(email: 'Bobby@example.com', comments: 'I cant wait to party down!')

    click_link 'Comments'

    expect(page).to have_content user.name
    expect(page).to have_content('I cant wait to party down!')
  end

  scenario 'Comments are not dispalyed if they are empty' do
    user = create_user(email: 'Bobby@example.com', comments: "")

    click_link 'Comments'

    expect(page).to have_no_content user.name
  end
end

