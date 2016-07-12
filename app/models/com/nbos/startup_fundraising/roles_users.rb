module Com
	module Nbos
		module StartupFundraising	
			class RolesUsers < ActiveRecord::Base
				belongs_to :user, class_name: "Com::Nbos::User" 
				belongs_to :role, class_name: "Com::Nbos::StartupFundraising::Role"
			end
		end
	end
end