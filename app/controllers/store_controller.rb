class StoreController < ApplicationController
  def index
  	@posters = Poster.order(:title)
  end
end
