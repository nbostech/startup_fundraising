class Api::StartupFundraising::V0::Nbos::CompaniesController < Api::StartupFundraising::V0::StartupBaseController
	
	before_action :validate_token

	 # Method to Return content about 50k network 
	 def index
		 companyType = params[:company_type]
     company_categories = ['deal_bank', 'funding_progress', 'portfolio']
		 if companyType.present? && company_categories.include?(companyType)
		 	 if companyType == "portfolio"  
         @companies_list = Com::Nbos::StartupFundraising::Company.active_companies.where(tenant_id: @token_details.tenantId).joins(:company_profile).where(company_profiles: {is_funded: true}).page(params[:page])
       elsif companyType == "deal_bank"
         @companies_list = []
       elsif companyType == "funding_progress"
         @companies_list = []
       end 
			 paginate json: @companies_list, per_page: params[:per_page] || 5
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end	

end	