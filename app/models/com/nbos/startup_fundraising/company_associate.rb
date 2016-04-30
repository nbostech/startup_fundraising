module Com
	module Nbos
		module StartupFundraising
			class CompanyAssociate < ActiveRecord::Base
				belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
				belongs_to :associate_team, class_name: "Com::Nbos::StartupFundraising::AssociateTeam" 
				has_many :assets, as: :imageable, class_name:"Com::Nbos::StartupFundraising::Asset"
			  has_many :addresses , as: :addressable, class_name:"Com::Nbos::StartupFundraising::Address"
			end 
		end
	end
end		
