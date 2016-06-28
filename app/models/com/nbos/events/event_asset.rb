module Com
  module Nbos
    module Events	
			class EventAsset < ActiveRecord::Base
			 belongs_to :imageable, polymorphic: true
       has_attached_file :image, :styles => { :small => "48x48",:medium => "300x200"},
			                    :path => ":rails_root/public/images/media/events/:id/:style/:basename.:extension",
			                    :url => "/images/media/events/:id/:style/:basename.:extension",
			                    :default_url => "/images/default/missing_image.png"
       validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
			 attr_accessor :delete_image 
       before_destroy :delete_image
    
			 def delete_image
			 	 image.clear
			 end

			 def extension
         self.image_content_type
			 end

			 def mediaFileDetailsList
			 	  if Rails.env == "development"
			 	  	host = "http://localhost:3000"
			 	  else
			 	  	host = "http://fundr.api.qa1.nbos.in"
			 	  end
			 	  image_list = []
			 	  ["medium", "small", "original"].each do |st|
			 	  	image_size_content = {}
			 	  	image_size_content["mediapath"] = host + self.image.url(st.to_sym)
			 	  	image_size_content["mediatype"]	= st
			 	  	image_list << image_size_content
			 	  end
			 	  image_list
			 end

			 def supportedsizes
			 	 "small:48x48,medium:300x200"
			 end	

			 def as_json(options={})
					super(:only => [:id], 
								:methods => [:extension, :mediaFileDetailsList, :supportedsizes]
					     )
			 end

			end
		end
	end
end			
