class AddUuidColumnToEventRsvpTable < ActiveRecord::Migration
  def change
  	add_column :event_rsvps, :uuid, :string, :null => true
  end
end
