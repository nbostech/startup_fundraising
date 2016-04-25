module Com
  module Nbos
    module StartupFundraising	
			class CompanyProfile < ActiveRecord::Base
			 self.table_name="company_profiles"	
			 belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"

			 has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
			                   :path => ":rails_root/public/images/compnay_profile/:id/:style/:basename.:extension",
			                   :url => "/images/compnay_profile/:id/:style/:basename.:extension",
			                   :default_url => "/images/default/missing_image.png"
       validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
       
       has_attached_file :document, :path => ":rails_root/public/documents/compnay/:id/:style/:basename.:extension",
			                   :url => "/images/documents/:id/:style/:basename.:extension"
			                   
       validates_attachment :document, 
                            :content_type => { 
                            	:content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) 
                              }
			 validates :email, :full_name, :contact_number, presence: true
			 validates :email, uniqueness: true

			 before_destroy :delete_image

			 def delete_image
			 	 image.clear
			 end

			end
		end
	end
end
			
