module Com
  module Nbos
    module Events	
			class Event < ActiveRecord::Base
			 has_many :event_rsvps, class_name: "Com::Nbos::Events::EventRsvp"
			 has_many :users, through: :event_rsvps

			 has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
       validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
			 
			 scope :active_events, -> { where(is_active: true) }
			end
		end
	end
end			
