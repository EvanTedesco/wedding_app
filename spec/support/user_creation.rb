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
    email: 'bob@example.com',
    password: 'password',
    name: 'Bob',
    max_guests: 1,
    admin: false,
  }
  User.create!(defaults.merge(attributes))
end

def create_guest(attributes = {})
  defaults = {
    name: 'Guest name',
  }
  Guest.create!(defaults.merge(attributes))
end
