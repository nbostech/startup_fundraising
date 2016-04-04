class CreateCompanyStage < ActiveRecord::Migration
  def change
    create_table :company_stages do |t|
    	t.string :name
    	t.string :desc
    	t.boolean :is_active, default: true

    	t.timestamps null: false
    end
  end
end
