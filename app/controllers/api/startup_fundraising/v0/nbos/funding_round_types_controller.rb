class Api::StartupFundraising::V0::Nbos::FundingRoundTypesController < Api::StartupFundraising::V0::StartupBaseController
before_action :validate_token
 def index
 	 @funding_round_types = Com::Nbos::StartupFundraising::FundingRoundType.all
 	 render :json => @funding_round_types
 end	
end