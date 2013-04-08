class PosterTagItem < ActiveRecord::Base
  attr_accessible :poster_id, :tag_id
  belongs_to :poster
  belongs_to :tag
end
