def create_admin(password)
  User.create!(email: 'evan@example.com', password: password, name:'Evan Tedesco', max_guests:1, admin:true)
end

def create_user(password)
  User.create!(email: 'bob@example.com', password: password, name:'Bob Smith', max_guests:1, admin: false)
end