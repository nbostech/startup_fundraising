class Api::StartupFundraising::V0::Nbos::UsersController < Api::StartupFundraising::V0::StartupBaseController
	
	before_action :validate_token, except: [:index, :portfolio]

	 # Method to Return all investors & startups
	 # based on user_type & tenant query params
	 def index
		 tenantId = params[:tenant_id]
		 user_type = params[:user_type]
		 if ["investor", "startup"].include?(user_type) && tenantId.present?
			 user_profiles = Com::Nbos::User.getUsers(user_type, tenantId)
			 render :json => {status: 200, data: user_profiles.to_json}
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end
	 
	 # Method to create users
	 def sign_up
		 if params[:user].present?
			 member = build_user(params[:user])
			 if member.save
			 	 data = {user: member, user_profile: member.profile, role: member.roles.first.name}
				 render :json => {status: 200, data: data}
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

	 # Method to Return all Funded Startups
	 # As 50k network portfolio
	 def portfolio
		 tenantId = params[:tenant_id]
		 if tenantId.present?
			 portfolio_list = Com::Nbos::User.getPortfolio(tenantId)
			 render :json => {status: 200, data: portfolio_list}
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

	 def dealbank
     if params[:id].present?
     	 member = Com::Nbos::User.find(params[:id])
       user_profiles = Com::Nbos::User.getDealbank(member.tenant_id)
			 if user_profiles.present?
				 render :json => {status: 200, data: user_profiles.to_json}
			 else
				 render :json => {status: 404, message: "User Not Found"}
			 end  
	 	 else
	 	 	render :json => {status: 400, message: "Bad Request"}
	 	 end
	 end

	 def fund_in_progress
     if params[:id].present?
     	 member = Com::Nbos::User.find(params[:id])
       user_profiles = Com::Nbos::User.getFundInProgress(member.tenant_id)
			 if user_profiles.present?
				 render :json => {status: 200, data: user_profiles.to_json}
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
     	 startup = Com::Nbos::User.find(params[:startup_id])
       add_to_favorite = Com::Nbos::StartupFundraising::Favourite.create(favourited: startup, user: investor)
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
			 	 favourite_startups_list = investor.favourite_profiles
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
		 member = Com::Nbos::User.new 
		 member.uuid = @token_details.uuid
		 member.tenant_id = @token_details.tenantId
		 
		 profile = Com::Nbos::StartupFundraising::Profile.new
		 profile.email = user_params["details"]["email"]
		 profile.contact_number = user_params["details"]["contact_number"]

		 api_response = getMediaApi.get_media(user_params["id"], "profile", @auth_token])
		 if api_response[:status] == 200
			media = api_response[:media]
			profile_image_path = media.mediaFileDetailsList[1].to_h["mediapath"]
			profile.idn_image_url = profile_image_path
		 end		

		 if user_params["user_type"] == "startup"
			member.is_active = false
			startup_role = Com::Nbos::StartupFundraising::Role.where(name: "startup").first
			member.roles << startup_role
			profile.startup_name = user_params["details"]["startup_name"]
			profile.founder_name = user_params["details"]["founder_name"]
			member.profile = profile
			member.is_funded = false
		 elsif user_params["user_type"] == "investor"
			member.is_active = true
			investor_role = Com::Nbos::StartupFundraising::Role.where(name: "investor").first
			member.roles << investor_role
			profile.full_name = user_params["details"]["full_name"]
			profile.company_name = user_params["details"]["company_name"]
			member.profile = profile
		 end	 
		member
	 end	

end	