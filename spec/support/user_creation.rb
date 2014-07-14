def create_admin(attributes= {})
  defaults = {
    email: 'evan@example.com',
    password: 'password',
    name: 'Evan Tedesco',
    max_guests: 1,
    admin: true,
  }
  User.create!(defaults.merge(attributes))
end

def create_user(attributes= {})
  defaults = {
    email: "bob#{rand(10000)}@example.com",
    password: 'password',
    name: 'Bob',
    max_guests: 1,
    admin: false,
  }
  User.create!(defaults.merge(attributes))
end

def create_guest(attributes = {})
  defaults = {
    food_id: 1,
    name: 'Guest name',
  }
  Guest.create!(defaults.merge(attributes))
end
