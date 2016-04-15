module Com
  module Nbos
    module Events	
			class Event < ActiveRecord::Base
			 has_many :event_rsvps, class_name: "Com::Nbos::Events::EventRsvp"
			 has_many :users, through: :event_rsvps

			 has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
			                   :path => ":rails_root/public/images/events/:id/:style/:basename.:extension",
			                   :url => "/images/events/:id/:style/:basename.:extension",
			                   :default_url => "/images/events/default/missing_event.png"
       validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
			 
			 scope :active_events, -> { where(is_active: true) }

			 validates :name, :address, :start_date, :location, presence: true

			 before_destroy :delete_image

			 def image_url
			 	  if Rails.env == "development"
			 	  	host = "http://localhost:3000"
			 	  else
			 	  	host = "https://startup-50kherokuapp.com"
			 	  end 	
			 	  host + image.url(:medium)
			 end

			 def delete_image
			 	 image.clear
			 end	
			 	  
			 def as_json(options={})
          super(:only => [:id, :name, :description, :address, :location, :contact_person, :contact_number, :website, :start_time, :end_time, :start_date], :methods => [:image_url])
       end 
			end
		end
	end
end			
