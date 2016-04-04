module Com
  module Nbos
    module StartupFundraising	
			class Investment < ActiveRecord::Base
			  belongs_to :user, class_name: "Com::Nbos::User"
			  belongs_to :current_funding_round, class_name: "Com::Nbos::StartupFundraising::CurrentFundingRound"
			end
		end
	end
end				