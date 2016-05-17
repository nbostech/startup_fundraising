module Com
	module Nbos
		module StartupFundraising
			class CompanyAssociate < ActiveRecord::Base
				belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
				belongs_to :associate_team, class_name: "Com::Nbos::StartupFundraising::AssociateTeam" 
				has_many :assets, as: :imageable, class_name:"Com::Nbos::StartupFundraising::Asset" , dependent: :destroy
			  has_many :addresses , as: :addressable, class_name:"Com::Nbos::StartupFundraising::Address", dependent: :destroy
				
				validates :email, :name, :contact_number, presence: true

				def address
					self.addresses.first
				end

				def profileImage
					 self.assets.where(img_type: "associate_profile").first 
				end	
					
				def as_json(options={})
					super(:except => [:associate_team_id, :company_id], 
								:methods => [:address, :profileImage]
					     )
				end 			
			end 
		end
	end
end		
