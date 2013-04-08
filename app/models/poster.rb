class Poster < ActiveRecord::Base
  attr_accessible :description, :price, :title, :image, :censored, :url
  has_many :poster_tag_items
  has_many :tags, through: :poster_tag_items
end

