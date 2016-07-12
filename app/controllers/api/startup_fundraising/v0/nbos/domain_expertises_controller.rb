class Api::StartupFundraising::V0::Nbos::DomainExpertisesController < Api::StartupFundraising::V0::StartupBaseController

	def index
		@domain_expertises = Com::Nbos::StartupFundraising::DomainExpertise.all
		render :json => @domain_expertises
	end
end