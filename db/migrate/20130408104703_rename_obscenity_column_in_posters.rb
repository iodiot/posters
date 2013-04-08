class RenameObscenityColumnInPosters < ActiveRecord::Migration
  def change
  	rename_column :posters, :obscenity, :censored
  end
end
