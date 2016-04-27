class CreateCompanyTable < ActiveRecord::Migration
  def change
    create_table :companies do |t|
			t.belongs_to :company_category
			t.belongs_to :company_stage
			t.belongs_to :currency_type
			t.boolean :is_funded, default: false
			t.boolean :is_approved, default: false
			
			t.timestamps null: false
    end
  end
end
