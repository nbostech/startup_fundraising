class CreateCompanyDocument < ActiveRecord::Migration
  def change
    create_table :company_documents do |t|
    	t.belongs_to :company_document_category
    	t.belongs_to :company
    end
    add_attachment :company_documents, :document
  end
end
