def create_and_login_user(attributes = {})
  user = create_user(attributes)
  visit '/sessions/new'
  fill_in 'user[email]', with: user.email
  fill_in 'user[password]', with: user.password
  click_button 'Login'
end

def create_and_login_admin(attributes = {} )
  admin_user = create_admin(attributes)
  visit '/sessions/new'
  fill_in 'user[email]', with: admin_user.email
  fill_in 'user[password]', with: admin_user.password
  click_button 'Login'
end

