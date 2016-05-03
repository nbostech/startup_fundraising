module Com
  module Nbos
    module StartupFundraising	
			class CompanyProfile < ActiveRecord::Base
			 belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"

			 validates :email, :startup_name, :contact_number, presence: true
			 

			 	def as_json(options={})
					super(:except => [:company_id, :updated_at, :created_at])
				end
			end
		end
	end
end
			
