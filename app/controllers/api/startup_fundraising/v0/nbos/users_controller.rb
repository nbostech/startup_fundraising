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
		 	 @existing_member = Com::Nbos::User.where(uuid: params[:uuid])
		 	 if @existing_member.present?
         render :json => @existing_member.first
			 else
			 	 @member = build_user(params)
				 if @member && @member.save
					 render :json => @member
				 else
					 render :json => {status: 500, message: @member.errors.messages}
				 end
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
      @member = Com::Nbos::User.where("id = ? or uuid = ?", params[:id], params[:id])
			 if @member.present?
				 render :json => @member.first
			 else
				 render :json => {status: 404, message: "User Not Found"}, status: 404
			 end  
	 	 else
	 	 	render :json => {status: 400, message: "Bad Request"}, status: 400
	 	 end	
	 end

	 def update
	 	 if @token_details.uuid.present?
       @member = Com::Nbos::User.where(uuid: @token_details.uuid).first
			 if @member.present?
         if @member.profile.update(params[:user].permit!)
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
			 profile.full_name = user_params["full_name"]
			 profile.email = user_params["email"]
			 profile.contact_number = user_params["contact_number"]
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