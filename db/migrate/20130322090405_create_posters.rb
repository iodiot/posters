class CreatePosters < ActiveRecord::Migration
  def change
    create_table :posters do |t|
      t.string :title
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
