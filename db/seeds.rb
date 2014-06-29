# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = [
  {email: 'evan@example.com', password: 'password', name:'Evan Tedesco', max_guests:1, admin:true},
  {email: 'blair@example.com', password: 'password', name:'Blair', max_guests:1, admin:false}
]

users.each do |user|
  User.create(user)
end

meals = [
  {name: 'Steak', description: 'Savory'},
  {name: 'Bacon', description: 'yumm'}
]

meals.each do |meal|
  Food.create(meal)
end



