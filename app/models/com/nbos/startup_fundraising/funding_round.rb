module Com
  module Nbos
    module StartupFundraising
			class FundingRound < ActiveRecord::Base
				belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
        has_many :investments, class_name: "Com::Nbos::StartupFundraising::Investment"
			end
	  end
	end
end		
