class CreateDocument < ActiveRecord::Migration
  def change
    create_table :documents do |t|
    	t.belongs_to :document_type
    	t.references :attachable, polymorphic: true, index: true
    	t.string :content_type
    	t.string :content_provider_url
    end
    add_attachment :documents, :document
  end
end
