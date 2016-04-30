class CreateProfiles < ActiveRecord::Migration
	def change
		create_table :profiles do |t|
			t.string :full_name
			t.string :email
			t.integer :contact_number
			t.string :location
			t.string :website
			t.text :profile_summary
			t.string :linkedin_profile
			t.string :facebook_profile
			t.string :twitter_profile
			t.string :other_profile
			t.string :social_accounts
			t.string :idn_image_url
			t.belongs_to :user, index: true
			t.timestamps null: false
		end
	end
end
