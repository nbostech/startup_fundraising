class Api::StartupFundraising::V0::Nbos::CompanyCategoriesController < Api::StartupFundraising::V0::StartupBaseController
before_action :validate_token
 def index
 	 @company_categories = Com::Nbos::StartupFundraising::CompanyCategory.all
 	 render :json => @company_categories
 end	
end