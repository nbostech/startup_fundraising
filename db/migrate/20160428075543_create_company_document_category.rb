class CreateCompanyDocumentCategory < ActiveRecord::Migration
  def change
    create_table :company_document_categories do |t|
    	t.string :name
    	t.string :tenant_id
    	t.string :description
    end
  end
end
