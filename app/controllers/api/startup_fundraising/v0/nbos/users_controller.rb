class Api::StartupFundraising::V0::Nbos::UsersController < Api::StartupFundraising::V0::StartupBaseController
	
	before_action :validate_token

	 # Method to Return all investors & startups
	 # based on user_type & tenant query params
	 def index
		 user_type = params[:user_type]
		 if ["investor", "startup"].include?(user_type)
		 	 
			 	role_id = Com::Nbos::StartupFundraising::Role.where(name: params[:user_type]).first.id
			  @user_profiles = Com::Nbos::User.active_users.where(tenant_id: @token_details.tenantId).joins(:roles_users).where(roles_users: {role_id: role_id}).page(params[:page])

			 paginate json: @user_profiles, per_page: params[:per_page]
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end
	 
	 # Method to create users
	 def sign_up
		 if params[:uuid].present?
			 @member = build_user(params)
			 if @member && @member.save
				 render :json => @member
			 else
				 render :json => {status: 500, message: @member.errors.messages}
			 end  
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end

	 # Method to create users
	 def login
		 if params[:uuid].present?
			 @member = Com::Nbos::User.where(uuid: params[:uuid])
			 if @member.present?
				 render :json => @member
			 else
				 render :json => {status: 404, message: "User Not Found"}
			 end  
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end		

	 def show
	 	 if params[:id].present?
      @member = Com::Nbos::User.find(params[:id])
			 if @member.present?
				 render :json => @member
			 else
				 render :json => {status: 404, message: "User Not Found"}
			 end  
	 	 else
	 	 	render :json => {status: 400, message: "Bad Request"}
	 	 end	
	 end

	 def update
	 	 if @token_details.uuid.present?
       @member = Com::Nbos::User.where(uuid: @token_details.uuid).first
			 if @member.present?
         if @member.profile.update(params)
           render :json => @member
         else
           render :json => {status: 500, message: @member.errors.messages}
         end    
			 else
				 render :json => {status: 404, message: "User Not Found"}
			 end  
	 	 else
	 	 	render :json => {status: 400, message: "Bad Request"}
	 	 end	
	 end

	 def add_to_favourite
	 	 if params[:id].present? && @token_details.uuid.present?
     	 investor = Com::Nbos::User.where(uuid: @token_details.uuid).first
     	 company = Com::Nbos::StartupFundraising::Company.find(params[:id])
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
			 	 @favourite_startups_list = investor.favourites.companies
				 render :json => @favourite_startups_list
			 else
				 render :json => {status: 404, message: "User not Found"}
			 end  
	 	 else
	 	 	render :json => {status: 400, message: "Bad Request"}
	 	 end 
	 end	


	 private

	 def build_user(user_params)
		if user_params["user_type"] == "startup"
       member = Com::Nbos::User.new
			 member.uuid = @token_details.uuid
			 member.tenant_id = @token_details.tenantId
			 
			 profile = Com::Nbos::StartupFundraising::Profile.new
			 profile.full_name = user_params["full_name"]
			 profile.email = user_params["email"]
			 profile.contact_number = user_params["contact_number"]
			 profile.idn_image_url = ENV['IDN_HOST_URL'] + "/Media/default/default-profile_300x200.png"


			 member.is_public = true
			 member.profile = profile

			 startup_role = Com::Nbos::StartupFundraising::Role.where(name: "Startup").first
			 member.roles << startup_role

			 member
		elsif user_params["user_type"] == "investor"
			 member = Com::Nbos::User.new 
			 member.uuid = @token_details.uuid
			 member.tenant_id = @token_details.tenantId
			 
			 profile = Com::Nbos::StartupFundraising::Profile.new
			 profile.full_name = user_params["details"]["full_name"]
			 profile.email = user_params["details"]["email"]
			 profile.contact_number = user_params["details"]["contact_number"]
			 profile.company_name = user_params["details"]["company_name"]
			 profile.idn_image_url = ENV['IDN_HOST_URL'] + "/Media/default/default-profile_300x200.png"


			 member.is_public = true
			 investor_role = Com::Nbos::StartupFundraising::Role.where(name: "Investor").first
			 member.roles << investor_role
			 member.profile = profile
			 member		
		else
		  return false	
		end	
	 end	

end	