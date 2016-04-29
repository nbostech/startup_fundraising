class CreateAddressesCompanies < ActiveRecord::Migration
  def change
    create_table :addresses_companies do |t|
    	t.belongs_to :company
    	t.belongs_to :address
    end
  end
end
