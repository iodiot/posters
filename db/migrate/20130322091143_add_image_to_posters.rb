class AddImageToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :image, :string
  end
end
