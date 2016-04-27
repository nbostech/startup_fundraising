class CreateCompanyProfiles < ActiveRecord::Migration
  def change
    create_table :company_profiles do |t|
			t.string :startup_name
			t.string :email
			t.integer :contact_number
			t.integer :emp_strength
			t.string :founder_name
			t.string :location
			t.text :address
			t.string :website
			t.text :business_summary
			t.text :description
			t.text :usb_product_uniqueness
			t.belongs_to :company, index: true
			t.integer :date_funded
			t.integer :year_funded
			t.string :linkedin_media_url
			t.string :twitter_media_url
			t.string :facebook_media_url
			t.string :other_media_url
			t.integer :capital_raised
			t.integer :previous_capital
			t.integer :monthly_net_burn
			t.integer :pre_money_valuation
			t.timestamps null: false
    end
  end
end
