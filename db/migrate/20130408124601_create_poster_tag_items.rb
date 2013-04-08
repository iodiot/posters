class CreatePosterTagItems < ActiveRecord::Migration
  def change
    create_table :poster_tag_items do |t|
      t.integer :poster_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
