class StoreController < ApplicationController	
	include Toolkit
	
	helper_method :pluralize_russian

	def initialize
		super
	end

  def index
    @order = params[:order] || "mysterious"
		  	 	
  	@posters = Poster.order(@order == "new" ? :updated_at : "RANDOM()").page(params[:page]).per(12)
  	
  	@posters_count = Poster.count
  	@categories = Tag.all
  end
  
  def show
  	@poster = Poster.find(params[:id])
  end
  
  def get_ss
  	render text: SearchSuggestion.limit(1).order("RANDOM()").first.title
  end
  
  def search
   	@order = params[:order] || "mysterious"
   	@search_string = params["input-search"] || ""
   	@posters = Poster.search(@search_string)
   	@posters = Kaminari.paginate_array(@posters).page(params[:page]).per(12)
  	@posters_count = @posters.count
  	@categories = Tag.all
  	
		render action: :index
  end
end
