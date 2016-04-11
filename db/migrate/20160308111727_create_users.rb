class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :uuid
			t.boolean :is_public, default: true
			t.boolean :is_authorized, default: false
			t.boolean :is_delete, default: false
			t.string :tenant_id, index: true
			
			t.timestamps null: false
		end
	end
end
