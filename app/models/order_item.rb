class OrderItem < ActiveRecord::Base
  attr_accessible :paper_bg, :paper_size, :poster_id, :quantity, :order_id
  belongs_to :order
  belongs_to :poster
end
