module Com
	module Nbos
		module StartupFundraising
			class FundingRound < ActiveRecord::Base
				belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
				has_many :investment_commitments, class_name: "Com::Nbos::StartupFundraising::InvestmentCommitment"
				belongs_to :funding_round_type, class_name: "Com::Nbos::StartupFundraising::FundingRoundType"

				def fundingProgressPercent
					funded_amount = self.investment_commitments.sum("invested_amount")
					funded_amount_percent = funded_amount/(self.seeking_amount/100)
					funded_amount_percent
				end

				def fundingroundType
					self.funding_round_type.name if self.funding_round_type.present?
				end

				def as_json(options={})
					super(:only => [:id, :seeking_amount, :closing_date, :minimum_investment],
								:methods => [:fundingroundType, :fundingProgressPercent])
				end
			end
		end
	end
end
