# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Poster.delete_all
Poster.create(title: 'Cat and orange portal',	description: '', price: 120.0, image: 'orange_portal.jpg')
Poster.create(title: 'Cat and blue portal', 	description: '', price: 120.0, image: 'blue_portal.jpg')
Poster.create(title: 'Final answer', 					description: '', price: 100.0, image: '42.jpg')

puts 'Default entries were added into posters.'

