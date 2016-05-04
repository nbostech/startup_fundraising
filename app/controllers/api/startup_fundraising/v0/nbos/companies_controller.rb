class Api::StartupFundraising::V0::Nbos::CompaniesController < Api::StartupFundraising::V0::StartupBaseController
  
  before_action :validate_token
 
   def index
     companyType = params[:company_type]
     company_categories = ['deal_bank', 'funding_progress', 'portfolio']
     if companyType.present? && company_categories.include?(companyType)
       if companyType == "portfolio"  
         @companies_list = Com::Nbos::StartupFundraising::Company.active_companies.where(is_funded: true).page(params[:page])
       elsif companyType == "deal_bank"
         @companies_list = Com::Nbos::StartupFundraising::Company.active_companies.where(is_funded: true).page(params[:page])
       elsif companyType == "funding_progress"
         @companies_list = Com::Nbos::StartupFundraising::Company.active_companies.where(is_funded: true).page(params[:page])
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
     if params[:startup_name].present? && @token_details.present? && @token_details.username.present?

       @member = Com::Nbos::User.where(uuid: @token_details.uuid).first
       company = Com::Nbos::StartupFundraising::Company.new
       profile_params = params.except(:controller, :action)
       company_profile = Com::Nbos::StartupFundraising::CompanyProfile.new(profile_params.permit!)
       company.company_profile = company_profile
       
       if company.save
          @member.companies << company
          @member.save
          render :json => @member
       else
          render :json => {status: 500, message: company.errors.messages}
       end   
     else
       render :json => {status: 400, message: "Bad Request"}
     end  
   end

   def update_profile
    if params[:id].present? && @token_details.present? && @token_details.username.present?
      @company = Com::Nbos::StartupFundraising::Company.find(params[:id])
      
      company_category = Com::Nbos::StartupFundraising::CompanyCategory.exists?(name: params[:company_category]) ? Com::Nbos::StartupFundraising::CompanyCategory.find_by(name: params[:company_category]) : nil
      company_stage = Com::Nbos::StartupFundraising::CompanyStage.exists?(name: params[:company_stage]) ? Com::Nbos::StartupFundraising::CompanyStage.find_by(name: params[:company_stage]) : nil
      currency_type = Com::Nbos::StartupFundraising::CurrencyType.exists?(code: params[:currency_type]) ? Com::Nbos::StartupFundraising::CurrencyType.find_by(name: params[:currency_type]) : nil

      @company.company_category_id = company_category.id if company_category.present?
      @company.company_stage_id = company_stage.id if company_category.present?
      @company.currency_type_id = currency_type.id if currency_type.present?
      
      profile_params = params.except(:id, :company_stage, :company_category, :currency_type, :action, :controller)

      @company.company_profile.update_columns(profile_params)
      if @company.save
        render :json => @company
      else
        render :json => { status: 500, message: "Internal Server Error"}
      end  
    else
      render :json => {status: 400, message: "Bad Request"}
    end  
   end  

   def show
     if params[:id].present?
       @company = Com::Nbos::StartupFundraising::Company.where(id: params[:id]).first
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
       company_profile.email = params["email"]
       company_profile.founder_name = params["founder_name"]
       company_profile.startup_name = params["company_name"]
       company_profile.contact_number = params["contact_number"]
       
       if company_profile.save
          render :json => {status: 200, message: "Company updated successfully."}
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