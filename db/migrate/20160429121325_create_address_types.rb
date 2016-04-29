class CreateAddressTypes < ActiveRecord::Migration
  def change
    create_table :address_types do |t|
    	t.string :name
    	t.string :description
    	t.string :tenant_id
    end
  end
end
