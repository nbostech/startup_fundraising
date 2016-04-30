module Com
  module Nbos
    module StartupFundraising
			class Document < ActiveRecord::Base
        belongs_to :attachable, polymorphic: true
        belongs_to :document_type, class_name: "Com::Nbos::StartupFundraising::DocumentType"
		  
        has_attached_file :document, :path => ":rails_root/public/documents/:id/:basename.:extension",
			                   :url => "/documents/:id/:basename.:extension"
			                   
        validates_attachment :document, 
                            :content_type => { 
                            	:content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) 
                              }
		  
        before_destroy :delete_document

         def delete_document
           document.clear
         end
      end
		end
	end
end		
