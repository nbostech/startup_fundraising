module Com
  module Nbos
    module StartupFundraising
			class FundingRound < ActiveRecord::Base
				belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
        has_many :investments, class_name: "Com::Nbos::StartupFundraising::Investment"
        belongs_to :funding_round_type, class_name: "Com::Nbos::StartupFundraising::FundingRoundType"
			end
	  end
	end
end		
