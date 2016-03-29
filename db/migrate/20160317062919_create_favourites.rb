class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.references :favourited, polymorphic: true, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
