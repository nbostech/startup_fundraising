class CreateCompanyAssociate < ActiveRecord::Migration
  def change
    create_table :company_associates do |t|
    	t.string :name
    	t.string :email
    	t.belongs_to :company
    	t.belongs_to :associate_category
    	t.string :position
    	t.text :experience_and_expertise
    end
    add_attachment :company_associates, :image
  end
end
