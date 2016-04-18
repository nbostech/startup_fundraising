class AddImageUploadColumnsToCompanyProfile < ActiveRecord::Migration
  def change
  	add_attachment :company_profiles, :image
  end
end
