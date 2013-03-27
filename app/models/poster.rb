class Poster < ActiveRecord::Base
  attr_accessible :description, :price, :title, :image
  has_many :tags
end
