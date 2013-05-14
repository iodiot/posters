class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :notes, :phone
  has_many :buys
end
