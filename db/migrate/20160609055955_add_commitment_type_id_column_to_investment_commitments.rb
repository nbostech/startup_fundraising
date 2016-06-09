class AddCommitmentTypeIdColumnToInvestmentCommitments < ActiveRecord::Migration
  def change
  	add_column :investment_commitments, :commitment_type_id, :integer
  end
end
