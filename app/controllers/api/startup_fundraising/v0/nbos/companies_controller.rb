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
     if params[:company_name].present? && @token_details.present? && @token_details.username.present?

       member = Com::Nbos::User.where(uuid: @token_details.uuid).first
       company = Com::Nbos::StartupFundraising::Company.new
       company.company_category_id = params[:company_category_id] || Com::Nbos::StartupFundraising::CompanyCategory.first.id
       company.company_stage_id = params[:company_stage_id] || Com::Nbos::StartupFundraising::CompanyStage.first.id
       company.currency_type_id = params[:currency_type_id] || Com::Nbos::StartupFundraising::CurrencyType.first.id

       company_profile = Com::Nbos::StartupFundraising::CompanyProfile.new(params)
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

   def add_team_member
     if params[:id].present?
       company = Com::Nbos::StartupFundraising::Company.find(params[:id])
       team_member = Com::Nbos::StartupFundraising::CompanyAssociate.new
       team_member.name = params[:name]
       team_member.email = params[:email]
       team_member.contact_number = params[:contact_number]
       team_member.position = params[:position]
       team_member.experience_and_expertise = params[:experience_and_expertise]
       team_member.associate_team_id = params[:associate_team_id]
       if team_member.save
         render :json => {status: 200, message: "Team Member Added Successfully."}
       else
         render :json => {status: 500, message: team_member.errors.messages}
       end  
     else
       render :json => {status: 400, message: "Bad Request"}
     end   
   end 

end 