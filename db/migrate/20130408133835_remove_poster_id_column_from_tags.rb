class RemovePosterIdColumnFromTags < ActiveRecord::Migration
  def change 
  	remove_column :tags, :poster_id
  end
end
