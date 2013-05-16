require "random_word_generator"

class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :message, :phone, :placed, :word
  has_many :buys
  
  def initialize
  	super
  	assign_unique_word
  end
  
  private
  
  def assign_unique_word
  	self.word = RandomWordGenerator.word
  end
end
