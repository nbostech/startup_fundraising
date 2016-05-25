class AddJoinTableForUserProfileAndDomianExpertise < ActiveRecord::Migration
  def change
  	create_table :domain_expertises_profiles do |t|
    	t.belongs_to :profile, index: true
    	t.belongs_to :domain_expertise, index: true
    end
  end
end
