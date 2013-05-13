class AddAutoKeysColumnToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :auto_keys, :text, default: ""
  end
end
