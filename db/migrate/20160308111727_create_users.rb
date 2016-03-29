class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :uuid
			t.boolean :is_active, default: false
			t.string :tenant_id, index: true
			
			t.timestamps null: false
		end
	end
end
