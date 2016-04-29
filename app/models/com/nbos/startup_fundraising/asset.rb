module Com
  module Nbos
    module StartupFundraising	
			class Asset < ActiveRecord::Base
        has_attached_file :image, :styles => { :small => "48x48",:medium => "300x300>"},
			                    :path => ":rails_root/public/images/compnay_profile/logo_images/:id/:style/:basename.:extension",
			                    :url => "/images/compnay_profile/:id/:style/:basename.:extension",
			                    :default_url => "/images/default/missing_image.png"
       validates_attachment :logo_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
			
       before_destroy :delete_image

			 def delete_image
			 	 image.clear
			 end
			end
		end
	end
end			
