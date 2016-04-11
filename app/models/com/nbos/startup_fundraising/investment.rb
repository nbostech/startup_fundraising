module Com
  module Nbos
    module StartupFundraising	
			class Investment < ActiveRecord::Base
			  belongs_to :user, class_name: "Com::Nbos::User"
			  belongs_to :funding_round, class_name: "Com::Nbos::StartupFundraising::FundingRound"
			end
		end
	end
end				