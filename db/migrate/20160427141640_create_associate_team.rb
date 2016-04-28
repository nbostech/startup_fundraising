class CreateAssociateTeam < ActiveRecord::Migration
  def change
    create_table :associate_teams do |t|
    	t.string :name
    	t.string :description
    	t.string :tenant_id
    end
  end
end
