class CreateProfiles < ActiveRecord::Migration
	def change
		create_table :profiles do |t|
			t.string :full_name
			t.string :email
			t.integer :contact_number
			t.string :company_name
			t.string :startup_name
			t.integer :emp_strength
			t.string :founder_name
			t.string :location
			t.string :website
			t.string :business_category
			t.text :business_summary
			t.string :description
			t.text :profile_summary
			t.string :profile_links
			t.string :social_accounts
			t.boolean :is_funded, default: false
			t.integer :current_fund
			t.integer :required_fund
			t.string :idn_image_url
			t.string :shared_document_url
			t.belongs_to :user, index: true
			t.timestamps null: false
		end
	end
end
