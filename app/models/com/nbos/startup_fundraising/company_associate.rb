module Com
	module Nbos
		module StartupFundraising
			class CompanyAssociate < ActiveRecord::Base
				belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
				belongs_to :associate_team, class_name: "Com::Nbos::StartupFundraising::AssociateTeam" 
			
        has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
			                   :path => ":rails_root/public/images/compnay_associate/:id/:style/:basename.:extension",
			                   :url => "/images/compnay_associate/:id/:style/:basename.:extension",
			                   :default_url => "/images/default/missing_image.png"
       validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
			end 
		end
	end
end		
