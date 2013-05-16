class StoreController < ApplicationController	
	include Toolkit
	
	helper_method :pluralize_russian
	
	before_filter :check_current_order, :count_buys, :define_variables
	
	def initialize
		super
	end
	
	def change_quantity
    order = get_current_order
    @buys = order.placed ? [] : order.buys
    id = params["id"].to_i
    value = params["value"].to_i
    
    # clamp
    value = 1 if value < 1
    value = 10 if value > 10
    
   	# update quantity and save 
    @buys.each do |b|
    	if b.id == id
    		b.quantity = value
    		b.save!
    		order.save!
    		break
    	end
    end
    
    count_buys

		render text: (render_to_string partial: "shared/cart_list")
	end
	
	def filter_by_tag
		if @tag.nil?
			redirect_to action: :home
			return
		end 
	
  	@body_class = "long-page"

  	@posters = get_posters
  	@posters = @posters.select {|p| p.tags.include?(@tag)}
  	@posters_count = @posters.count	# save count before pagination
  	@posters = Kaminari.paginate_array(@posters).page(@page).per(12)
  	
  	render action: :home
	end
	

  def home 
  	@body_class = "long-page"
  	
  	@posters = get_posters.page(@page).per(12) 	
  	@posters_count = Poster.count
  end
  
  def item
  	  	@safemode_visible = false
  
  	@poster = Poster.find(params["id"])
  	@tags = Tag.all
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
 		@cart_chosen = true
  	@safemode_visible = false
  
    order = get_current_order
    @buys = order.placed ? [] : order.buys
  end
  
  def checkout  
  	order = get_current_order
  	
  	order.name = params["name"]
  	order.email = params["email"]
  	order.phone = params["phone"]
  	order.address = params["address"]
  	order.message = params["message"]
  	order.placed = true
  	
  	order.save!
  	
  	flush_current_order
  	
  	#redirect_to action: :home
  	render xml: order	# debug
  end
  
  def get_ss
  	render text: SearchSuggestion.limit(1).order("RANDOM()").first.title
  end
  
  def search
  	@body_class = "long-page"

   	@posters = Poster.search(@search_string)
  	@posters_count = @posters.count
   	@posters = Kaminari.paginate_array(@posters).page(@page).per(12)
  	
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
	
	def count_buys
		@buys_count = 0
		get_current_order.buys.each {|b| @buys_count += b.quantity}
		@buys_count
	end
	
	def get_posters
		Poster.order(@sorting == "new" ? :updated_at : "RANDOM()")
	end
	
	def define_variables
		@cart_chosen = false
		@safemode_visible = true
		@body_class = ""
   	@sorting = params["sorting"] || "mysterious"
   	@search_string = params["input-search"] || ""
    @tag = params["tag"].nil? ? nil : Tag.find_by_url(params["tag"])
    @page = params[:page] || 0
    @return_to = request.referer
    
    @tags = Tag.all
	end
end
