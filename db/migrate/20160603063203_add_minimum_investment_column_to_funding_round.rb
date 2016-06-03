class AddMinimumInvestmentColumnToFundingRound < ActiveRecord::Migration
  def change
  	add_column :funding_rounds, :minimum_investment, :integer
  end
end
