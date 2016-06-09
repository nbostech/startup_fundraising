class ChangeInvestmentTableName < ActiveRecord::Migration
  def change
  	rename_table :investments, :investment_commitments
  end
end
