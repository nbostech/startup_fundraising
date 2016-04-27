class CreateCurrencyType < ActiveRecord::Migration
  def change
    create_table :currency_types do |t|
    	t.string :code
    	t.string :symbol
    	t.string :description
    end
  end
end
