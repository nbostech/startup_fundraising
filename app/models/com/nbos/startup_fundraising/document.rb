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
        
        def document_type
          self.document_type.name
        end

        def document_path
          if self.content_provider_url.present?
            self.content_provider_url
          else
            host = Rails.env == "development" ? "http://localhost:3000" : "https://startup-50k.herokuapp.com"
            host + self.document.url
          end 
        end

        def document_format
          if self.content_type.present?
            self.content_type
          else
            self.document_content_type
          end  
        end  

        def as_json(options={})
          super(:except => [:document_type_id, :created_at, :updated_at], 
                :methods => [:document_type, :document_path, :document_format]
               )
        end         
      end
		end
	end
end		
