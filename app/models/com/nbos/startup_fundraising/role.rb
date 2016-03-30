module Com
  module Nbos
    module StartupFundraising	
			class Role < ActiveRecord::Base
			 has_many :user_roles, class_name: "Com::Nbos::StartupFundraising::UserRole"
			 has_many :users, through: :user_roles, class_name: "Com::Nbos::User"

			 validates :name, presence: true 
			 validates :name, uniqueness: true
			end
		end
	end
end			
