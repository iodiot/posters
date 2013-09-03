class RemoveWordColumnFromOrders < ActiveRecord::Migration
  def change
  	remove_column :orders, :word
  end
end
