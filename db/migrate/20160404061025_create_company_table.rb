class CreateCompanyTable < ActiveRecord::Migration
  def change
    create_table :companies do |t|
    	t.string :uuid
			t.boolean :is_public, default: true
			t.boolean :is_aprroved, default: false
			t.boolean :is_delete, default: false
			t.string :tenant_id, index: true
			t.belongs_to :category
			t.belongs_to :company_stage
			
			t.timestamps null: false
    end
  end
end
