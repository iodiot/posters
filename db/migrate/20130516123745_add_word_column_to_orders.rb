class AddWordColumnToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :word, :string, default: ""
  end
end
