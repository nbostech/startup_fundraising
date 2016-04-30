class CreateCompanyAssociate < ActiveRecord::Migration
  def change
    create_table :company_associates do |t|
    	t.string :name
    	t.string :email
    	t.belongs_to :company
    	t.belongs_to :associate_team
    	t.string :position
    	t.text :experience_and_expertise
      t.integer :contact_number
      t.string :location
      t.string :website
      t.text :profile_summary
      t.string :linkedin_profile
      t.string :facebook_profile
      t.string :twitter_profile
      t.string :other_profile
    end
  end
end
