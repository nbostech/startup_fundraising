class RenameTableFavouritesToFavorites < ActiveRecord::Migration
  def change
  	rename_table :favourites, :favorites
  	rename_column :favorites, :favouritable_id, :favoritable_id
  	rename_column :favorites, :favouritable_type, :favoritable_type
  end
end
