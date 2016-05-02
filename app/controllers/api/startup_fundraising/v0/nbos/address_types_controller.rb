class Api::StartupFundraising::V0::Nbos::AddressTypesController < Api::StartupFundraising::V0::StartupBaseController

 def index
 	 @address_types = Com::Nbos::StartupFundraising::AddressType.all
 	 render :json => @address_types
 end	
end