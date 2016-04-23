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
			 paginate json: @companies_list, per_page: params[:per_page]
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end

	 def create
	 	debugger
     if params[:company].present? && @token_details.present? && @token_details.username.present?

       member = Com::Nbos::User.where(uuid: @token_details.uuid).first
     	 company = Com::Nbos::StartupFundraising::Company.new
			 company.uuid = @token_details.uuid
			 company.tenant_id = @token_details.tenantId
			 company.is_public = true

			 company_profile = Com::Nbos::StartupFundraising::CompanyProfile.new
			 company_profile.email = params["company"]["email"]
			 company_profile.founder_name = params["company"]["founder_name"]
			 company_profile.startup_name = params["company"]["company_name"]
			 company_profile.contact_number = params["company"]["contact_number"]
			 company_profile.full_name = params["company"]["full_name"]

			 company.company_profile = company_profile
       
       member.companies << company
       render :json => {status: 200, message: "Company created successfully."}
     else
     	 render :json => {status: 400, message: "Bad Request"}
     end	
	 end	

end	