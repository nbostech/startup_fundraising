class CreateFundingRoundType < ActiveRecord::Migration
  def change
    create_table :funding_round_types do |t|
    	t.string :name
    	t.string :description
    	t.string :tenant_id
    end

    add_column :funding_rounds, :funding_round_type_id, :integer
  end
end
