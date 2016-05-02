class Api::StartupFundraising::V0::Nbos::CompanySummaryTypesController < Api::StartupFundraising::V0::StartupBaseController
before_action :validate_token
 def index
 	 @summary_types = Com::Nbos::StartupFundraising::CompanySummaryType.all
 	 render :json => @summary_types
 end	
end