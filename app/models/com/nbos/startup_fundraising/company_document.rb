module Com
  module Nbos
    module StartupFundraising
			class CompanyDocument < ActiveRecord::Base
        belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
        belongs_to :company_document_category, class_name: "Com::Nbos::StartupFundraising::CompanyDocumentCategory"
		  
        has_attached_file :document, :path => ":rails_root/public/documents/compnay/:id/:basename.:extension",
			                   :url => "/company/documents/:id/:basename.:extension"
			                   
        validates_attachment :document, 
                            :content_type => { 
                            	:content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) 
                              }
		  end
		end
	end
end		
