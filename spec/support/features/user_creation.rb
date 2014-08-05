def create_and_login_user(attributes ={})
  user = create_user(attributes)

  visit '/sessions/new'
  fill_in 'user[email]', with: user.email
  fill_in 'user[password]', with: user.password
  click_button 'Login'
end

