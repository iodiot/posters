require "unicode"

class Poster < ActiveRecord::Base
  attr_accessible :description, :price, :title, :image, :censored, :url, :manual_keys, :auto_keys
  has_many :poster_tag_items
  has_many :tags, through: :poster_tag_items
  before_save :generate_auto_keys
  
 	def self.search(phrase, opts={})
  	Poster::Search.new(phrase, opts).go!
	end
	
	def generate_auto_keys
		self.auto_keys = Search::generate_keys(title + " " + description).join(" ") 
	end
	
	private
	
	class Search
		attr_accessor :phrase, :keys, :conditions, :query, :query_string, :results, :limit
	
		def self.generate_keys(text)
			# extract words from text
			return [] if text.nil?
			keys = text.scan(/[[:alnum:]]+/)
			keys.collect! {|k| Unicode::upcase(k)}
			
			# exclude soft words from keys
			soft_words = []
			File.open(Rails.root.join("soft_words").to_s, "r") do |f|
				f.lines.each {|l| soft_words << Unicode::upcase(l.chomp)}
			end
			soft_words.each {|sw| keys.delete sw}
			
			keys.sort.uniq
		end
	
		def initialize(phrase, opts = {})
			@phrase = phrase
			@keys = self.class.generate_keys(@phrase)	
			@fields = ["auto_keys", "manual_keys"]
			@limit = opts[:limit] || 100
		end
	
		def go!
			return [] if @keys == [] || @keys.nil?
		  build_conditions_and_query
		  assemble_query
		  #return get_map_weight_and_sort_results
		  
		  get_results
		end
	
		private
		
		def get_map_weight_and_sort_results
		  get_results
		  map_results
		  weight_map
		  return sort_map_and_return_articles
		end
	
		def build_conditions_and_query
			@conditions = []
			@query = []
		
		 	@keys.each do |k|
		  	@fields.each {|f| @query << "upper(#{f}) LIKE ?"}
		 	 	@fields.size.times { @conditions << "%#{k}%" }
			end
		end
	
		def assemble_query      
			@query_string = "(#{@query.join(" OR ")})"
		end
		
		def get_results 
			search_opts = {conditions: [@query_string, @conditions].flatten}
			search_opts[:limit] = @limit
			@results = Poster.all(search_opts)
		end
		
		def sort_results
			map = {}
			@results.each {|r| map}
		end  
	end
end


