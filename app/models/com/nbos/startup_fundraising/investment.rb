module Com
  module Nbos
    module StartupFundraising	
			class Investment < ActiveRecord::Base
			  belongs_to :user, class_name: "Com::Nbos::User"
			  belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company", foreign_key: "company_id"
			end
		end
	end
end				