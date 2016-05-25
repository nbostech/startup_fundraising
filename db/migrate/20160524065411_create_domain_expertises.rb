class CreateDomainExpertises < ActiveRecord::Migration
  def change
    create_table :domain_expertises do |t|
    	t.string :name
    	t.string :tenant_id
    	t.string :description
    	t.integer :parent_id
    end
  end
end
