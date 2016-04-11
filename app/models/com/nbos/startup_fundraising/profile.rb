module Com
  module Nbos
    module StartupFundraising	
			class Profile < ActiveRecord::Base
			 belongs_to :user, class_name: "Com::Nbos::User", foreign_key: "user_id"

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
			
