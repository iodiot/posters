class StoreController < ApplicationController
  def index
  	@posters = Poster.order(:title)
  end
  
  def show
  	@poster = Poster.find(params[:id])
  end
end
