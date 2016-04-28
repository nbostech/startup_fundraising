class Api::StartupFundraising::V0::Nbos::CurrencyTypesController < Api::StartupFundraising::V0::StartupBaseController

 def index
 	 @currency_types = Com::Nbos::StartupFundraising::CurrencyType.all
 	 render :json => @currency_types
 end	
end