module Com
  module Nbos
    module Events	
			class Event < ActiveRecord::Base
			 has_many :event_rsvps, class_name: "Com::Nbos::Events::EventRsvp"
			 has_many :users, through: :event_rsvps

			 has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
			                   :path => ":rails_root/public/images/events/:id/:style/:basename.:extension",
			                   :url => "/images/events/:id/:style/:basename.:extension",
			                   :default_url => "/images/default/missing_image.png"
       validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
			 
			 scope :active_events, -> { where(is_active: true) }

			 validates :name, :address, :start_date, :location, presence: true

			 before_destroy :delete_image

			 attr_accessor :schedule_time, :schedule_date

			 def image_url
			 	  if Rails.env == "development"
			 	  	host = "http://localhost:3000"
			 	  else
			 	  	host = "https://startup-50k.herokuapp.com"
			 	  end 	
			 	  host + image.url(:medium)
			 end

			 def delete_image
			 	 image.clear
			 end

			 def schedule_time
			 	 self.start_time.strftime("%I:%M%p").to_s + "-" + self.end_time.strftime("%I:%M%p").to_s
			 end

			 def schedule_date
			 	 if self.start_date.present? && self.end_date.present?
			 	 	 self.start_date.strftime("%b %e").to_s + "-" + self.end_date.strftime("%b %e").to_s
			 	 else
			 	 	 self.start_date.strftime("%b %e").to_s
			 	 end	
			 end	
			 	  
			 def as_json(options={})
          super(:only => [:id, :name, :description, :address, :location, :contact_person, :contact_number, :website], :methods => [:image_url, :schedule_time, :schedule_date])
       end 
			end
		end
	end
end			
