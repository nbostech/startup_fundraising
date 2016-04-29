class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
    	t.float :longitude
        t.float :latitude
        t.string :address1
        t.string :street
    	t.string :city
    	t.string :state
    	t.string :country
    	t.integer :zip_code
    	t.belongs_to :address_type
    end
  end
end
