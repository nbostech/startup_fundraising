class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :address
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.string :location
      t.boolean :is_public, default: true
      t.boolean :is_active, default: true
      t.belongs_to :user, index: true
      t.string :tenant_id, index: true
      t.timestamps null: false
    end
  end
end
