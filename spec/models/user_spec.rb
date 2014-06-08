require 'spec_helper'

describe User do
it 'Prevents duplicate emails from being created' do
   valid_user = User.create!(email: 'evan@example.com', password: 'password', name:'Evan Tedesco', max_guests:1, admin: true)
   invalid_user = User.create(email: 'evan@example.com', password: 'password', name:'Evan Tedesco', max_guests:1, admin: true)

   expect(valid_user).to be_valid
   expect(invalid_user).to be_invalid
end

it 'Prevents users from being created without an email' do
   valid_user = User.create!(email: 'evan@example.com', password: 'password', name:'Evan Tedesco', max_guests:1, admin: true)
   invalid_user = User.create(email: '', password: 'password', name:'Evan Tedesco', max_guests:1, admin: true)

   expect(valid_user).to be_valid
   expect(invalid_user).to be_invalid
end

it 'Prevents users from being created with invalid guest count' do
   valid_user = User.create!(email: 'evan@example.com', password: 'password', name:'Evan Tedesco', max_guests:1, admin: true)
   invalid_user = User.create(email: 'evan@example.com', password: 'password', name:'Evan Tedesco', max_guests:'abc', admin: true)

   expect(valid_user).to be_valid
   expect(invalid_user).to be_invalid
end
end