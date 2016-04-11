class Api::StartupFundraising::V0::Nbos::CompaniesController < Api::StartupFundraising::V0::StartupBaseController
	
	before_action :validate_token

	 # Method to Return content about 50k network 
	 def index
		 companyType = params[:company_type]
     company_categories = ['deal_bank', 'funding_progress', 'portfolio']
		 if companyType.present? && company_categories.include?(companyType)
			 companies_list = Com::Nbos::StartupFundraising::Company.getCompaniesList(@token_details.tenantId, companyType)
			 render :json => {status: 200, data: companies_list}
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end	

end	