class StoreController < ApplicationController
	POSTERS_PER_PAGE = 1

  def index
  	@current_page = params[:page].to_i || 1
  	
  	n = @current_page * POSTERS_PER_PAGE - 1
  	
  	@posters = Poster.order(:title)
  	@posters = @posters[n..n + POSTERS_PER_PAGE - 1] || []
  	
  	@pages_count = Poster.count / POSTERS_PER_PAGE
  end
  
  def show
  	@poster = Poster.find(params[:id])
  end
end
