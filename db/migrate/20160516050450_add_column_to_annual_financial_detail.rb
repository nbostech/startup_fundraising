class AddColumnToAnnualFinancialDetail < ActiveRecord::Migration
  def change
  	add_column :annual_financial_details, :year, :integer
  end
end
