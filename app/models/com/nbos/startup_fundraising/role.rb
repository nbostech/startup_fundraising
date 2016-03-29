module Com
  module Nbos
    module StartupFundraising	
			class Role < ActiveRecord::Base
			 has_many :user_roles, class_name: "Com::Nbos::StartupFundraising::UserRole"
			 has_many :users, through: :user_roles, class_name: "Com::Nbos::User"	
			end
		end
	end
end			
