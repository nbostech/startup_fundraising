class Api::StartupFundraising::V0::Nbos::CompanySummaryTypesController < Api::StartupFundraising::V0::StartupBaseController

 def index
 	 @summary_types = Com::Nbos::StartupFundraising::CompanySummaryType.all
 	 render :json => @summary_types
 end	
end