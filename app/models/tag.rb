class Tag < ActiveRecord::Base
  attr_accessible :name, :poster_id, :url, :icon
  has_many :poster_tag_items
  has_many :posters, through: :poster_tag_items
end
