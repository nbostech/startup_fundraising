class Api::StartupFundraising::V0::Nbos::FundingRoundTypesController < Api::StartupFundraising::V0::StartupBaseController

	def index
		@funding_round_types = Com::Nbos::StartupFundraising::FundingRoundType.all
		render :json => @funding_round_types
	end
end