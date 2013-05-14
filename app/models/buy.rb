class Buy < ActiveRecord::Base
  attr_accessible :order_id, :paper_bg, :paper_size, :poster_id, :quantity
  belongs_to :order
  belongs_to :poster
end
