class CreateCompanyCategoriesProfiles < ActiveRecord::Migration
  def change
    create_table :company_categories_profiles do |t|
    	t.belongs_to :profile, index: true
    	t.belongs_to :company_category, index: true
    end
  end
end
