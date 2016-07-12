module Com
	module Nbos
		module StartupFundraising	
			class InvestmentCommitment < ActiveRecord::Base
				belongs_to :user, class_name: "Com::Nbos::User"
				belongs_to :funding_round, class_name: "Com::Nbos::StartupFundraising::FundingRound"
				belongs_to :commitment_type, class_name: "Com::Nbos::StartupFundraising::CommitmentType"
				

				def investor
					self.user.profile.full_name
				end

				def commitmentType
					self.commitment_type.name
				end

				def companyName
					self.funding_round.company.company_profile.startup_name
				end

				def as_json(options={})
					super(:only => [:id, :invested_amount],
								:methods => [:investor, :commitmentType, :companyName])
				end
			end
		end
	end
end