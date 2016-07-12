class Api::StartupFundraising::V0::Nbos::CompanyStagesController < Api::StartupFundraising::V0::StartupBaseController

	def index
		@company_stages = Com::Nbos::StartupFundraising::CompanyStage.all
		render :json => @company_stages
	end
end