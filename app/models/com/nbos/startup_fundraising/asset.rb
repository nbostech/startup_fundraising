module Com
  module Nbos
    module StartupFundraising	
			class Asset < ActiveRecord::Base
			 belongs_to :imageable, polymorphic: true
       has_attached_file :image, :styles => { :small => "48x48",:medium => "300x200>"},
			                    :path => ":rails_root/public/images/media/:id/:style/:basename.:extension",
			                    :url => "/images/media/:id/:style/:basename.:extension",
			                    :default_url => "/images/default/missing_image.png"
       validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
			
       before_destroy :delete_image

			 def delete_image
			 	 image.clear
			 end
			end
		end
	end
end			
