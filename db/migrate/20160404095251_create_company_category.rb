class CreateCompanyCategory < ActiveRecord::Migration
  def change
    create_table :company_categories do |t|
    	t.string :name
    	t.string :description
    	t.boolean :is_active, default: true

    	t.timestamps null: false
    end
  end
end
