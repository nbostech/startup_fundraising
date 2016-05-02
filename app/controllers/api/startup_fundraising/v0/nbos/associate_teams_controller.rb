class Api::StartupFundraising::V0::Nbos::AssociateTeamsController < Api::StartupFundraising::V0::StartupBaseController
before_action :validate_token
 def index
 	 @associate_teams = Com::Nbos::StartupFundraising::AssociateTeam.all
 	 render :json => @associate_teams
 end	
end