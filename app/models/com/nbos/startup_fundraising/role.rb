module Com
  module Nbos
    module StartupFundraising	
			class Role < ActiveRecord::Base
			 has_many :roles_users, class_name: "Com::Nbos::StartupFundraising::RolesUsers"
			 has_many :users, through: :roles_users, class_name: "Com::Nbos::User"

			 validates :name, presence: true 
			 validates :name, uniqueness: true
			end
		end
	end
end			
