class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.string :name
    	t.string :desc
    	t.boolean :is_active, default: true

    	t.timestamps null: false
    end
  end
end
