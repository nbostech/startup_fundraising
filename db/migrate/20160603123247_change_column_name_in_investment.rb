class ChangeColumnNameInInvestment < ActiveRecord::Migration
  def change
  	rename_column :investments, :current_funding_round_id, :funding_round_id
  end
end
