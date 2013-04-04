class AddObscenityToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :obscenity, :boolean
  end
end
