module Com
  module Nbos
    module StartupFundraising	
			class CompanyProfile < ActiveRecord::Base
			 self.table_name="company_profiles"	
			 belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"

			 validates :email, :full_name, :contact_number, presence: true
			 validates :email, uniqueness: true
			end
		end
	end
end
			
