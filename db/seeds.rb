# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Poster.delete_all
Tag.delete_all

(1..100).each do
	p1 = Poster.create(title: 'Cat and orange portal',	description: '', price: 120.0, image: 'orange_portal.jpg', censored: Random.rand(2) == 0)
	p2 = Poster.create(title: 'Cat and blue portal', 	description: '', price: 120.0, image: 'blue_portal.jpg', censored: Random.rand(2) == 0)
	Poster.create(title: 'Final answer', 					description: '', price: 100.0, image: '42.jpg', censored: Random.rand(2) == 0)
	
	Tag.create(name: 'Cat',		poster_id: p1.id)
	Tag.create(name: 'Portal',	poster_id: p1.id)
	Tag.create(name: 'Cat',		poster_id: p2.id)
	Tag.create(name: 'Portal',	poster_id: p2.id)
end

puts "#{Poster.count} posters were succesfully created..."


