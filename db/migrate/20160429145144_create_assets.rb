class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
    	t.string :img_type
      t.references :imageable, polymorphic: true, index: true
      t.timestamps null: false
    end
    add_attachment :assets, :image
  end
end
