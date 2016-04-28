module Com
  module Nbos
    module StartupFundraising	
			class Profile < ActiveRecord::Base
			 belongs_to :user, class_name: "Com::Nbos::User", foreign_key: "user_id"
			 validates :email, :full_name, :contact_number, presence: true
			 validates :email, uniqueness: true
			end
		end
	end
end
			
