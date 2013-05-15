class StoreController < ApplicationController	
	include Toolkit
	
	helper_method :pluralize_russian
	
	before_filter :check_current_order
	
	def initialize
		super
	end

  def home
  	@body_class = "long-page"
  	
    @sorting = params[:sorting] || "mysterious"
		  	 	
  	@posters = Poster.order(@sorting == "new" ? :updated_at : "RANDOM()").page(params[:page]).per(12)
  	
  	@posters_count = Poster.count
  	@categories = Tag.all
  end
  
  def item
  	@body_class = ""
  	@poster = Poster.find(params[:id])
  	@categories = Tag.all
  end
  
  def add_to_cart
  	order = get_current_order
  	
  	buy = Buy.new(poster_id: params["poster-id"], 
 			paper_size: params["paper-size"], paper_bg: params["paper-bg"], quantity: 1)
  	
  	# increase quantity of existing buyment if possible
  	found = false
  	order.buys.each do |b| 
  		b.equal_to?(buy)
  		if b.equal_to?(buy)
  			found = true
  			b.quantity += 1
  			b.save!
  			break
  		end
  	end
		order.buys << buy if !found
		order.save! 		
 			
 		redirect_to action: :cart
  end
  
  def remove_from_cart
  	Buy.destroy(params[:id]) if Buy.exists?(params[:id])
  	
  	redirect_to action: :cart
  end
  
  def cart
   	@body_class = ""
   	
    @categories = Tag.all   
    
    order = get_current_order
    @buys = order.placed ? [] : order.buys
  end
  
  def checkout
  	# user entered all fields?
  	@name = params[:name] || ""
  	@email = params[:email] || ""
  	@phone = params[:phone] || ""
  	@address = params[:address] || ""
  
  	order = get_current_order
  	order.placed = true
  	order.save!
  	
  	flush_current_order
  	
  	redirect_to action: :home
  end
  
  def get_ss
  	render text: SearchSuggestion.limit(1).order("RANDOM()").first.title
  end
  
  def search
   	@sorting = params[:sorting] || "mysterious"
   	@search_string = params["input-search"] || ""
   	@posters = Poster.search(@search_string)
   	@posters = Kaminari.paginate_array(@posters).page(params[:page]).per(12)
  	@posters_count = @posters.count
  	@categories = Tag.all
  	
		render action: :home
  end
  
	private
	
	def check_current_order
  	if session[:order_id].nil? || !Order.exists?(session[:order_id])
  		order = Order.new
  		order.save!
  		session[:order_id] = order.id
  	end
	end
	
	def get_current_order
		Order.find(session[:order_id])
	end
	
	def flush_current_order
		get_current_order = nil 
		session[:order_id] = nil
	end
end
