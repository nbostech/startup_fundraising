module Com
  module Nbos
    module StartupFundraising	
			class Investment < ActiveRecord::Base
			  belongs_to :user, class_name: "Com::Nbos::User", inverse_of: :investments
			  belongs_to :startup, class_name: "Com::Nbos::User", foreign_key: "startup_id"
			end
		end
	end
end				