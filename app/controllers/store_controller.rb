class StoreController < ApplicationController

  def index
  	@posters = Poster.order(:title).page(params[:page]).per(1) # one user per page, for testing	
  	@posters_count = Poster.count
  end
  
  def show
  	@poster = Poster.find(params[:id])
  end
end
