# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: "Chicago" }, { name: "Copenhagen" }])
#   Mayor.create(name: "Emanuel", city: cities.first)

Poster.delete_all
Tag.delete_all
PosterTagItem.delete_all
SearchSuggestion.delete_all
Order.delete_all
Buy.delete_all

# TEST DATA

suggestions = [	"God of War", "осторожно", "собака", "кин-дза-дза", "Instagram", 
								"Portal",	"How I Met Your Mother", "коты", "светофор", 
								"The Big Bang Theory", "House", "404", "курение", 
								"синхрофазотрон", "эволюция", "Tetris", "Firefox", 
								"Большой Лебовский", "Space Invaders", "пластилин", 
								"северное сияние" ]
							
suggestions.each {|s| SearchSuggestion.create(title: s)}

t1 = Tag.create(name: "Кошки", url: "cats")
t2 = Tag.create(name: "Игры", url: "games", icon: "games.png")
t3 = Tag.create(name: "Космос", url: "space", icon: "star.png")

(1..101).each do
	p1 = Poster.create(title: "Кот и оранжевый портал",	description: "Много оранжевого цвета.", price: 120.0, image: "orange_portal.jpg", censored: Random.rand(2) == 0, url: "cat-and-orange-portal")
	p2 = Poster.create(title: "Кот и синий портал", 		description: "Много синего цвета.", price: 120.0, image: "blue_portal.jpg", censored: Random.rand(2) == 0, url: "cat-and-blue-portal")
	p3 = Poster.create(title: "Окончательный ответ",		description: "Как известно, окончательный ответ -- это число 42.", price: 100.0, image: "42.jpg", censored: Random.rand(2) == 0, url: "42") 
	
	p1.tags << t1 << t2
	p2.tags << t1 << t2
	p3.tags << t3
	
	p1.save!
	p2.save!
	p3.save!
end

puts "#{Poster.count} posters were succesfully created..."


