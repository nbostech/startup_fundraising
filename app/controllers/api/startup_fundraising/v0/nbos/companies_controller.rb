class Api::StartupFundraising::V0::Nbos::CompaniesController < Api::StartupFundraising::V0::StartupBaseController
  
  before_action :validate_token
 
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
       if @token_details.present?
         member = Com::Nbos::User.where(uuid: @token_details.uuid).first
         @companies = member.companies
         paginate json: @companies, per_page: params[:per_page]
       else 
        render :json => {status: 400, message: "Bad Request"}
       end 
     end  
   end

   def create
     if params[:company_name].present? && @token_details.present? && @token_details.username.present?

       member = Com::Nbos::User.where(uuid: @token_details.uuid).first
       company = Com::Nbos::StartupFundraising::Company.new
       company.uuid = @token_details.uuid
       company.tenant_id = @token_details.tenantId
       company.is_public = true

       company_profile = Com::Nbos::StartupFundraising::CompanyProfile.new
       company_profile.startup_name = params["company_name"]
       company_profile.email = params["details"]["email"]
       company_profile.founder_name = params["details"]["founder_name"]
       company_profile.contact_number = params["details"]["contact_number"]

       company.company_profile = company_profile
       
       
       if company.save
          member.companies << company
          member.save
          render :json => {status: 200, message: "Company created successfully."}
       else
          render :json => {status: 500, message: company.errors.messages}
       end   
     else
       render :json => {status: 400, message: "Bad Request"}
     end  
   end

   def show
     if params[:id].present?
       @company = Com::Nbos::StartupFundraising::Company.find(params[:id])
       if @company.present?
         render :json => @company
       else
         render :json => {status: 404, message: "Company Not Found"}
       end  
     else
       render :json => {status: 400, message: "Bad Request"}
     end      

   end  

   def update
     if params[:id].present?
       company = Com::Nbos::StartupFundraising::Company.find(params[:id])
       company_profile = company.company_profile
       company_profile.email = params["details"]["email"]
       company_profile.founder_name = params["details"]["founder_name"]
       company_profile.startup_name = params["company_name"]
       company_profile.contact_number = params["details"]["contact_number"]
       
       if company_profile.save
          render :json => {status: 200, message: "Company created successfully."}
       else
          render :json => {status: 500, message: company.errors.messages}
       end   
     else
       render :json => {status: 400, message: "Bad Request"}
     end  
   end


   def delete
     if params[:id].present?
      company = Com::Nbos::StartupFundraising::Company.find(params[:id])
      member = Com::Nbos::User.where(uuid: @token_details.uuid).first
      member.companies.delete(company)
      render :json => {status: 200, message: "Company deleted successfully."}
     else
       render :json => {status: 400, message: "Bad Request"}
     end  
   end  

end 