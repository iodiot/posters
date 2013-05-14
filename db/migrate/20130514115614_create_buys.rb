class CreateBuys < ActiveRecord::Migration
  def change
    create_table :buys do |t|
      t.integer :poster_id
      t.integer :order_id
      t.string :paper_size
      t.string :paper_bg
      t.integer :quantity

      t.timestamps
    end
  end
end
