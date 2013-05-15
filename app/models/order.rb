class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :message, :phone, :placed
  has_many :buys
end
