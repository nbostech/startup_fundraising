class CreateEventRsvps < ActiveRecord::Migration
  def change
    create_table :event_rsvps do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :event
      t.string :rsvp_type
    	t.timestamps null: false
    end
  end
end
