class Poster < ActiveRecord::Base
  attr_accessible :description, :price, :title, :image, :obscenity
  has_many :tags
end
