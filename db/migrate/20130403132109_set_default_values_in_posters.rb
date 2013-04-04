class SetDefaultValuesInPosters < ActiveRecord::Migration
  def change
  	change_column :posters, :description, :string, default: ""
  	change_column :posters, :price, :decimal, default: 0.0
   	change_column :posters, :title, :string, default: ""
  	change_column :posters, :image, :string, default: ""
  	change_column :posters, :obscenity, :boolean, default: false
  end
end
