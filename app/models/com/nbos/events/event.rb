module Com
  module Nbos
    module Events	
			class Event < ActiveRecord::Base
			 has_many :event_rsvps, class_name: "Com::Nbos::Events::EventRsvp"
			 has_many :users, through: :event_rsvps

			 #has_attached_file :image, :styles => { :small => "48x48",:medium => "300x200"},
			 #                  :path => ":rails_root/public/images/events/:id/:style/:basename.:extension",
			 #                  :url => "/images/events/:id/:style/:basename.:extension",
			 #                  :default_url => "/images/default/missing_image.png"
       #validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
			 
			 has_many :event_assets, as: :imageable, class_name:"Com::Nbos::Events::EventAsset", dependent: :destroy

			 scope :active_events, -> { where(is_active: true) }

			 validates :name, :address, :start_date, :location, presence: true

			 before_destroy :delete_image

			 attr_accessor :schedule_time, :schedule_date

			 def image_url
			 	  self.event_assets.where(img_type: "event").first
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

			 def attendencies
         self.event_rsvps.count
			 end	
			 	  
			 def as_json(options={})
          super(:only => [:id, :name, :description, :address, :location, :contact_person, :contact_number, :website], :methods => [:image_url, :schedule_time, :schedule_date, :attendencies])
       end 
			end
		end
	end
end			
