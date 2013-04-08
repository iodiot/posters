class Poster < ActiveRecord::Base
  attr_accessible :description, :price, :title, :image, :censored
  has_many :tags
end

