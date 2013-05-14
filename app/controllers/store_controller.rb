class StoreController < ApplicationController	
	include Toolkit
	
	helper_method :pluralize_russian
	
	before_filter :check_order
	
	def initialize
		super
	end

  def home
  	@body_class = "long-page"
    @order = params[:order] || "mysterious"
		  	 	
  	@posters = Poster.order(@order == "new" ? :updated_at : "RANDOM()").page(params[:page]).per(12)
  	
  	@posters_count = Poster.count
  	@categories = Tag.all
  end
  
  def item
  	@body_class = ""
  	@poster = Poster.find(params[:id])
  	@categories = Tag.all
  end
  
  def add_to_cart
  	order = Order.find(session[:order_id])
  
 		buy = Buy.new(poster_id: params["poster-id"], 
 			paper_size: params["paper-size"], paper_bg: params["paper-bg"], quantity: 1)
 			
		order.buys << buy
		order.save! 		
 			
 		redirect_to action: :cart
  end
  
  def cart
   	@body_class = ""
    @categories = Tag.all   
    
    @buys = Order.find(session[:order_id]).buys
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
  	
		render action: :home
  end
  
	private
	
	def check_order
  	if session[:order_id].nil? || !Order.exists?(session[:order_id])
  		order = Order.new
  		order.save!
  		session[:order_id] = order.id
  	end
	end
end
