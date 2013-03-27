class AddPosterIdColumnToTags < ActiveRecord::Migration
  def change
    add_column :tags, :poster_id, :integer
  end
end
