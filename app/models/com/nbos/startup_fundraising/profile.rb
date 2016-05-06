module Com
  module Nbos
    module StartupFundraising	
			class Profile < ActiveRecord::Base
			 belongs_to :user, class_name: "Com::Nbos::User", foreign_key: "user_id"
			 validates :email, :full_name, :contact_number, presence: true
			 validates :email, uniqueness: true
			 has_many :addresses , as: :addressable, class_name:"Com::Nbos::StartupFundraising::Address"
			 
			 def as_json(options={})
				super(:except => [:user_id, :created_at, :updated_at, :idn_image_url])
			 end
			end
		end
	end
end
			
