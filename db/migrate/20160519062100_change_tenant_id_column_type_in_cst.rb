class ChangeTenantIdColumnTypeInCst < ActiveRecord::Migration
  def change
  	change_column :company_summary_types, :tenant_id, :string
  end
end
