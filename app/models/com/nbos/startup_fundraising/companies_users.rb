module Com
	module Nbos
		module StartupFundraising
			class CompaniesUsers < ActiveRecord::Base
				belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
				belongs_to :user, class_name: "Com::Nbos::User" 
			end 
		end
	end
end		
