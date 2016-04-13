class Api::StartupFundraising::V0::Nbos::UsersController < Api::StartupFundraising::V0::StartupBaseController
	
	#before_action :validate_token

	 # Method to Return all investors & startups
	 # based on user_type & tenant query params
	 def index
		 user_type = params[:user_type]
		 if ["investor", "startup"].include?(user_type)
		 	 if user_type == "startup"
			   @user_profiles = Com::Nbos::StartupFundraising::Company.active_companies.where(tenant_id: @token_details.tenantId).page(params[:page])
			 else
			 	 role_id = Com::Nbos::StartupFundraising::Role.where(name: params[:user_type]).first.id
				 @user_profiles = Com::Nbos::User.active_users.where(tenant_id: @token_details.tenantId).joins(:user_roles).where(user_roles: {role_id: role_id}).page(params[:page])
			 end  
			 paginate json: @user_profiles, per_page: params[:per_page] || 5
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end
	 
	 # Method to create users
	 def sign_up
		 if params[:user].present?
			 member = build_user(params[:user])
			 if member && member.save
				 render :json => {status: 200, message: "Registration was done successfully. 50k network will contact you."}
			 else
				 render :json => {status: 500, message: member.errors.messages}
			 end  
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end

	 # Method to create users
	 def login
		 if params[:user].present?
			 member = Com::Nbos::User.where(uuid: params[:user][:uuid])
			 if member.present?
			 	 data = {user: member, user_profile: member.profile, role: member.roles.first.name}
				 render :json => {status: 200, data: data}
			 else
				 render :json => {status: 404, message: "User Not Found"}
			 end  
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end		

	 def show
	 	 if params[:id].present?
      member = Com::Nbos::User.find(params[:id])
			 if member.present?
			 	 data = {user: member, user_profile: member.profile, role: member.roles.first.name}
				 render :json => {status: 200, data: data}
			 else
				 render :json => {status: 404, message: "User Not Found"}
			 end  
	 	 else
	 	 	render :json => {status: 400, message: "Bad Request"}
	 	 end	
	 end

	 def update
	 	 if params[:id].present? && params[:user].present?
       member = Com::Nbos::User.find(params[:id])
			 if member.present?
         if member.profile.update(params[:user])
         	 data = {user: member, user_profile: member.profile, role: member.roles.first.name}
           render :json => {status: 200, data: data}
         else
           render :json => {status: 500, message: "Internal Server Error"}
         end    
			 else
				 render :json => {status: 404, message: "User Not Found"}
			 end  
	 	 else
	 	 	render :json => {status: 400, message: "Bad Request"}
	 	 end	
	 end

	 def add_to_favourite
	 	 if params[:id].present? && params[:startup_id].present?
     	 investor = Com::Nbos::User.find(params[:id])
     	 company = Com::Nbos::StartupFundraising::Compnay.find(params[:startup_id])
       add_to_favorite = Com::Nbos::StartupFundraising::Favourite.create(favouritable: company, user: investor)
			 if add_to_favorite
				 render :json => {status: 200, message: "Success"}
			 else
				 render :json => {status: 404, message: "Internal Server Error"}
			 end  
	 	 else
	 	 	render :json => {status: 400, message: "Bad Request"}
	 	 end 
	 end

	 def favorite_startups
	 	 if params[:id].present?
     	 investor = Com::Nbos::User.find(params[:id])
			 if investor.present?
			 	 favourite_startups_list = investor.favourites.companies
				 render :json => {status: 200, data: favourite_startups_list}
			 else
				 render :json => {status: 404, message: "No Favourite Startups Found"}
			 end  
	 	 else
	 	 	render :json => {status: 400, message: "Bad Request"}
	 	 end 
	 end	


	 private

	 def build_user(user_params)
		if user_params["user_type"] == "startup"
       member = Com::Nbos::StartupFundraising::Company.new 
			 member.uuid = @token_details.uuid
			 member.tenant_id = @token_details.tenantId
			 
			 profile = Com::Nbos::StartupFundraising::CompanyProfile.new
			 profile.email = user_params["details"]["email"]
			 profile.contact_number = user_params["details"]["contact_number"]

			 api_response = getMediaApi.get_media(user_params["id"], "profile", @auth_token)
			 if api_response[:status] == 200
				media = api_response[:media]
				profile_image_path = media.mediaFileDetailsList[1].to_h["mediapath"]
				profile.idn_image_url = profile_image_path
			 end

			 member.is_public = true
			 profile.full_name = user_params["details"]["full_name"]
			 profile.company_name = user_params["details"]["company_name"]
			 member.company_profile = profile
			 member
		elsif user_params["user_type"] == "investor"
			 member = Com::Nbos::User.new 
			 member.uuid = @token_details.uuid
			 member.tenant_id = @token_details.tenantId
			 
			 profile = Com::Nbos::StartupFundraising::Profile.new
			 profile.email = user_params["details"]["email"]
			 profile.contact_number = user_params["details"]["contact_number"]

			 api_response = getMediaApi.get_media(user_params["id"], "profile", @auth_token)
			 if api_response[:status] == 200
				media = api_response[:media]
				profile_image_path = media.mediaFileDetailsList[1].to_h["mediapath"]
				profile.idn_image_url = profile_image_path
			 end

			 member.is_public = true
			 investor_role = Com::Nbos::StartupFundraising::Role.where(name: "investor").first
			 member.roles << investor_role
			 profile.full_name = user_params["details"]["full_name"]
			 profile.company_name = user_params["details"]["company_name"]
			 member.profile = profile
			 member		
		else
		  return false	
		end	
	 end	

end	