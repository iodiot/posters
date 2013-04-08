class StoreController < ApplicationController
	def initialize
		super
	end

  def index
  	@order = params[:order] || 'mysterious'
		  	 	
  	@posters = Poster.order(@order == 'new' ? :updated_at : 'RANDOM()').page(params[:page]).per(5)
  	
  	@posters_count = Poster.count
  	@categories = Tag.all
  end
  
  def show
  	@poster = Poster.find(params[:id])
  end
end
