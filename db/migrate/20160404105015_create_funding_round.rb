class CreateFundingRound < ActiveRecord::Migration
  def change
    create_table :funding_rounds do |t|
      t.integer :seeking_amount
      t.date :closing_date
      t.boolean :is_closed, default: false
      t.integer :company_id
      t.boolean :is_deleted, default: false

      t.timestamps null: false
    end
  end
end