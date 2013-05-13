class AddManualKeysColumnToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :manual_keys, :text, default: ""
  end
end
