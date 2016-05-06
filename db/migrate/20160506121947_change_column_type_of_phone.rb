class ChangeColumnTypeOfPhone < ActiveRecord::Migration
  def change
  	change_column :profiles, :contact_number,  :string
  	change_column :company_profiles, :contact_number,  :string
  	change_column :company_associates, :contact_number,  :string
  end
end
