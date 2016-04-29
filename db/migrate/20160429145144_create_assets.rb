class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
    	t.string :media_for
    end
    add_attachment :assets, :image
  end
end
