class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
    	t.references :favouritable, polymorphic: true, index: true
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
