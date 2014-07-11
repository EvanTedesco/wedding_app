require 'spec_helper'

feature 'Admin options' do
  before do
    DatabaseCleaner.clean
    @admin_user = create_admin
    @user = create_user
  end

  scenario 'Admin can view all RSVPS' do
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'
    click_on 'RSVPS'
    expect(page).to have_content 'RSVP List'
  end

  scenario 'An admin can create users' do
    number_of_users = User.all.length
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'
    click_on 'Users'
    fill_in 'user[name]', with: 'new user'
    fill_in 'user[email]', with: 'jeff@example.com'
    fill_in 'user[max_guests]', with: 1
    click_on 'Create user'
    expect(page).to have_content 'new user has been sent an invitation'
    expect(User.all.length).to eq(number_of_users + 1)

  end

  scenario 'An admin can delete users' do

    number_of_users = User.all.length
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'
    click_on 'Users'
    within("//tr[@id=#{@user.name}]") do
      click_on 'Delete'
    end
    expect(User.all.length).to eq (number_of_users - 1)

  end

  scenario 'Only an admin can add food choices' do
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'
    click_on 'Menu'
    click_on 'Add food item'
    fill_in 'food_name', with: 'Steak'
    fill_in 'food_description', with: 'Savory steak is savory'
    click_on 'Add food'
    expect(page).to have_content 'Steak'
    expect(page).to have_content 'Menu Items:'
    click_on 'Logout'
    click_on 'Login'
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Login'
    visit '/foods/new'
    expect(page).to have_no_content 'Add a food item'
    visit '/foods'
    expect(page).to have_no_content 'Menu Options'
  end

  scenario 'Admin can delete menu item' do
    create_food
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'
    click_on 'Menu'
    expect(page).to have_content 'Menu Items:'
    click_on 'Delete'
    expect(page).to have_no_content 'Edit: Steak'
  end

  scenario 'Admin can update menu items' do
    food = create_food
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'
    click_on 'Menu'
    click_on food.name
    fill_in 'food_name', with: 'Skirt steak'
    fill_in 'food_description', with: 'Savory skirt steak is savory'
    click_on 'Edit'
    expect(page).to have_content 'Savory skirt steak is savory'
    expect(page).to have_no_content food.name

  end

    scenario 'Admin can delete menu items' do
      visit '/sessions/new'
      fill_in 'user[email]', with: @admin_user.email
      fill_in 'user[password]', with: @admin_user.password
      click_button 'Login'
      click_on 'Menu'
      click_on 'Add food item'
      fill_in 'food_name', with: 'Steak'
      fill_in 'food_description', with: 'Savory steak is savory'
      click_on 'Add food'
      click_on 'Delete'
      expect(page).to have_no_content 'Steak'

    end

  scenario 'Admin user can see the guest names and food choice for a user' do
    food = create_food
    user = create_user(email:'Bobby@example.com', attending:true, number_of_guests: 1, max_guests: 2)
    guest = create_guest(user_id: user.id, food_id: food.id)
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'
    click_on 'RSVPS'
    click_on user.number_of_guests
    expect(page).to have_content user.name
    expect(page).to have_content guest.name
    expect(page).to have_content food.name
  end

  scenario 'Admin can see a list of all comments and their associated users' do
    create_user(email:'Bobby@example.com', attending:true, number_of_guests: 1,
                       max_guests: 2, comments: 'I cant wait to party down!')
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'
    click_on 'Comments'
    expect(page).to have_content('Bob')
    expect(page).to have_content('I cant wait to party down!')
  end

  scenario 'Comments are not dispalyed if they are empty' do
    user = create_user(email:'Bobby@example.com', attending:true, number_of_guests: 1,
                max_guests: 2)
    visit '/sessions/new'
    fill_in 'user[email]', with: @admin_user.email
    fill_in 'user[password]', with: @admin_user.password
    click_button 'Login'
    click_on 'Comments'
    expect(page).to have_no_content user.name
  end
end

