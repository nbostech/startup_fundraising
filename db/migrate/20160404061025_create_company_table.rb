class CreateCompanyTable < ActiveRecord::Migration
  def change
    create_table :companies do |t|
    	t.string :uuid
			t.boolean :is_active, default: false
			t.string :tenant_id, index: true
			t.belongs_to :category
			t.belongs_to :company_stage
			
			t.timestamps null: false
    end
  end
end
