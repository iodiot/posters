class Buy < ActiveRecord::Base
  attr_accessible :order_id, :paper_bg, :paper_size, :poster_id, :quantity
  belongs_to :order
  belongs_to :poster
  
  def equal_to?(o)
  	(self.poster_id == o.poster_id) && (self.paper_bg == o.paper_bg) && (self.paper_size == o.paper_size)
  end
end
