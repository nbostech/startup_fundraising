class CreateAnnualFinancialInfo < ActiveRecord::Migration
  def change
    create_table :annual_financial_infos do |t|
    	t.integer :annual_revenue_run_rate, limit: 8
    	t.integer :monthly_bun_rate, limit: 8
    	t.text :financial_annotation
      t.string :revenue_driver
      t.belongs_to :company
    end
  end
end
