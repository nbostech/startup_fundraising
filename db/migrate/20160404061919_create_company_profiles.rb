class CreateCompanyProfiles < ActiveRecord::Migration
  def change
    create_table :company_profiles do |t|
    	t.string :full_name
			t.string :email
			t.integer :contact_number
			t.string :startup_name
			t.integer :emp_strength
			t.string :founder_name
			t.string :location
			t.string :website
			t.integer :category_id
			t.text :business_summary
			t.string :description
			t.text :profile_summary
			t.string :profile_links
			t.string :social_accounts
			t.boolean :is_funded, default: false
			t.string :idn_image_url
			t.belongs_to :company, index: true
			t.integer :date_funded
			t.integer :year_funded
			t.string :currency
			t.integer :capital_raised
			t.timestamps null: false
    end
  end
end
