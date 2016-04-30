class CreateDocumentType < ActiveRecord::Migration
  def change
    create_table :document_types do |t|
    	t.string :name
    	t.string :tenant_id
    	t.string :description
    end
  end
end
