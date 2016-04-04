module Com
  module Nbos
    module StartupFundraising
			class CurrentFundingRound < ActiveRecord::Base
				belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"

			end
	  end
	end
end		
