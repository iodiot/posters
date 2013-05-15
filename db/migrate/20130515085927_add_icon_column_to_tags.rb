class AddIconColumnToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :icon, :text, default: ""
  end
end
