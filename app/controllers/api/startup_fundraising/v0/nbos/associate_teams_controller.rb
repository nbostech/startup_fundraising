class Api::StartupFundraising::V0::Nbos::AssociateTeamsController < Api::StartupFundraising::V0::StartupBaseController

	def index
		@associate_teams = Com::Nbos::StartupFundraising::AssociateTeam.all
		render :json => @associate_teams
	end
end