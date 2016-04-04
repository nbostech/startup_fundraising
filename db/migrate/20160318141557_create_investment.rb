class CreateInvestment < ActiveRecord::Migration
  def change
    create_table :investments do |t|
    	t.integer :user_id
    	t.integer :current_funding_round_id
    	t.integer :invested_amount

    	t.timestamps null: false
    end
  end
end
