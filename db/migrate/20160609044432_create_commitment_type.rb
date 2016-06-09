class CreateCommitmentType < ActiveRecord::Migration
  def change
    create_table :commitment_types do |t|
    	t.string :name
    	t.string :tenant_id
    	t.string :description
    	t.boolean :is_deleted
    	t.boolean :is_active
    end
  end
end
