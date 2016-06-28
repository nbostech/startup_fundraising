class EventAsstes < ActiveRecord::Migration
  def change
    create_table :event_assets do |t|
    	t.string :img_type
      t.references :imageable, polymorphic: true, index: true
      t.timestamps null: false
    end
    add_attachment :event_assets, :image
  end
end
