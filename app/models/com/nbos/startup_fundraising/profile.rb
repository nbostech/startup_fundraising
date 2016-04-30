module Com
  module Nbos
    module StartupFundraising	
			class Profile < ActiveRecord::Base
			 belongs_to :user, class_name: "Com::Nbos::User", foreign_key: "user_id"
			 validates :email, :full_name, :contact_number, presence: true
			 validates :email, uniqueness: true
			 has_many :addresses , as: :addressable, class_name:"Com::Nbos::StartupFundraising::Address"
			end
		end
	end
end
			
