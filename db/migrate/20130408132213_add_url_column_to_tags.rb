class AddUrlColumnToTags < ActiveRecord::Migration
  def change
    add_column :tags, :url, :string, default: ''
  end
end
