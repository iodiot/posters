class AddIconColumnToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :icon, :string, default: ""
  end
end
