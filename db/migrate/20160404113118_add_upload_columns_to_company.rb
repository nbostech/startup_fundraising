class AddUploadColumnsToCompany < ActiveRecord::Migration
	def change
		add_attachment :company_profiles, :document
	end
end
