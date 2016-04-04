class CreateProfiles < ActiveRecord::Migration
	def change
		create_table :profiles do |t|
			t.string :full_name
			t.string :email
			t.integer :contact_number
			t.string :company_name
			t.string :location
			t.string :website
			t.text :profile_summary
			t.string :profile_links
			t.string :social_accounts
			t.string :idn_image_url
			t.belongs_to :user, index: true
			t.timestamps null: false
		end
	end
end
