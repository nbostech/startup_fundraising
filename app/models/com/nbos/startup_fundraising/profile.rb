module Com
  module Nbos
    module StartupFundraising	
			class Profile < ActiveRecord::Base
			 belongs_to :user, class_name: "Com::Nbos::User", foreign_key: "user_id"
			 validates :email, :full_name, :contact_number, presence: true
			 #validates :email, uniqueness: true
			 has_many :addresses , as: :addressable, class_name:"Com::Nbos::StartupFundraising::Address"
			 has_and_belongs_to_many :company_categories, class_name: "Com::Nbos::StartupFundraising::CompanyCategory"
			 has_and_belongs_to_many :domain_expertises, class_name: "Com::Nbos::StartupFundraising::DomainExpertise"
			 def as_json(options={})
				super(:except => [:user_id, :created_at, :updated_at, :idn_image_url])
			 end
			end
		end
	end
end
			
