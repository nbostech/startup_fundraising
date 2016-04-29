class CreateCompanyAssets < ActiveRecord::Migration
  def change
    create_table :company_assets do |t|
    	t.belongs_to :company
      t.belongs_to :asset
    end
  end
end
