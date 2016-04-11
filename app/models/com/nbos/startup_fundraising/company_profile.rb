module Com
  module Nbos
    module StartupFundraising	
			class CompanyProfile < ActiveRecord::Base
			 self.table_name="company_profiles"	
			 belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"

			 has_attached_file :document
       validates_attachment :document, 
                            :content_type => { 
                            	:content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) 
                              }
			 validates :email, :full_name, :contact_number, presence: true
			 validates :email, uniqueness: true
			end
		end
	end
end
			
