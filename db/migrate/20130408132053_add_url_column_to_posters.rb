class AddUrlColumnToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :url, :string, default: ''
  end
end
