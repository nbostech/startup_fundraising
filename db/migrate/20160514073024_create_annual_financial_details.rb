class CreateAnnualFinancialDetails < ActiveRecord::Migration
  def change
    create_table :annual_financial_details do |t|
    	t.integer :revenue_driver_count, limit: 8
    	t.integer :revenue, limit: 8
    	t.integer :expenditure, limit: 8
    	t.belongs_to :annual_financial_info
    end
  end
end
