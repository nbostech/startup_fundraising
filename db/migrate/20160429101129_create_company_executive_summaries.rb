class CreateCompanyExecutiveSummaries < ActiveRecord::Migration
  def change
    create_table :company_executive_summaries do |t|
      t.belongs_to :company_summary_type
      t.belongs_to :company
      t.text :description
      t.timestamps null: false
    end
  end
end
