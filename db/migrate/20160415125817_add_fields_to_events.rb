class AddFieldsToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :contact_person, :string
  	add_column :events, :contact_number, :integer
  	add_column :events, :website, :string
  end
end
