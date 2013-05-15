class RenameNotesColumnInOrders < ActiveRecord::Migration
  def change
  	rename_column :orders, :notes, :message
  end
end
