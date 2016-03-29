class CreateInvestment < ActiveRecord::Migration
  def change
    create_table :investments do |t|
    	t.integer :user_id
    	t.integer :startup_id
    	t.integer :amount

    	t.timestamps null: false
    end
  end
end
