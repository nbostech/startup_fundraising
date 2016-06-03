module Com
	module Nbos
		module StartupFundraising
			class FundingRound < ActiveRecord::Base
				belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
				has_many :investments, class_name: "Com::Nbos::StartupFundraising::Investment"
				belongs_to :funding_round_type, class_name: "Com::Nbos::StartupFundraising::FundingRoundType"
			  
			  def fundingProgressPercent
			    funded_amount = self.investments.sum("invested_amount")
			    funded_amount_percent = funded_amount/(self.seeking_amount/100)
			    funded_amount_percent 
			  end
			  	
				def as_json(options={})
				 super(:only => [:seeking_amount, :closing_date, :minimum_investment],
				 	     :methods => [:fundingProgressPercent])
				end
			end
		end
	end
end		
