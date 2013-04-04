class StoreController < ApplicationController
	def initialize
		@safe_mode = true
		super
	end

  def index
  	@posters = Poster.order("RANDOM()").page(params[:page]).per(5)
  	@posters_count = Poster.count
  end
  
  def show
  	@poster = Poster.find(params[:id])
  end
end
