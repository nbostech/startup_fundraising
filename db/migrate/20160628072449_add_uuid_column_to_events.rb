class AddUuidColumnToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :uuid, :string, :null => true
  end
end
