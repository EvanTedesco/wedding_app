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

photos = [
  {user_id: 1, url: "http://31.media.tumblr.com/ba7758a52675589e05dc931572be9688/tumblr_n7ygur3NV91st5lhmo1_1280.jpg"},
  {user_id: 1, url: "http://33.media.tumblr.com/db092b1795916eb81a0a87f6d5473d0e/tumblr_n7yidlujvS1st5lhmo1_1280.jpg"},
  {user_id: 1, url: "http://31.media.tumblr.com/d851e225242e4d90baada35ba4d996f5/tumblr_n7yif13ZKl1st5lhmo1_1280.jpg"},
  {user_id: 1, url: "http://38.media.tumblr.com/4e9d8c075b15f5922682bfaa13a8125c/tumblr_n7yhezarqF1st5lhmo1_1280.jpg"},
]
photos.each do |photo|
  Photo.create!(photo)
end



