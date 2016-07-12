class Api::StartupFundraising::V0::Nbos::CommitmentTypesController < Api::StartupFundraising::V0::StartupBaseController

	def index
		@commitment_types = Com::Nbos::StartupFundraising::CommitmentType.all
		render :json => @commitment_types
	end
end