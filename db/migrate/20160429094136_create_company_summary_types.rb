class CreateCompanySummaryTypes < ActiveRecord::Migration
  def change
    create_table :company_summary_types do |t|
      t.string :name
      t.string :description
      t.integer :tenant_id
      t.timestamps null: false
    end
  end
end
