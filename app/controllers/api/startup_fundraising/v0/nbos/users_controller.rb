class Api::StartupFundraising::V0::Nbos::UsersController < Api::StartupFundraising::V0::StartupBaseController

	before_action :get_member, only: [:update]

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
					render :json => {status: 500, message: @member.errors.messages}, status: 500
				end
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end	
	end

	def login
		if params[:uuid].present?
			@member = Com::Nbos::User.where(uuid: params[:uuid])
			if @member.present?
				session[:current_user] = @member.first
				render :json => @member.first
			else
				render :json => {status: 404, message: "User Not Found"}, status: 404
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end
	end

	def sign_out
		if @token_details.present?
			api_response = getAuthApi.logout(@token_details.token)
			if api_response[:status] == 200
				session[:current_user] = nil
				render :json => {status: 200, message: "Success"}, status: 200
			else
				render :json => {status: api_response[:status], message: "Something went wrong"}, status: api_response[:status]
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
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
		if @member.present?
			profile_params = params[:user].except(:areaofInterests,:domainExpertises).permit!
			if params[:areaofInterests].present?
				@member.profile.company_categories.clear
				params[:areaofInterests].each do |ai|
					area_of_interest = Com::Nbos::StartupFundraising::CompanyCategory.where(name: ai["name"]).first
					@member.profile.company_categories << area_of_interest if area_of_interest.present?
				end
			end

			if params[:domainExpertises].present?
				@member.profile.domain_expertises.clear
				params[:domainExpertises].each do |de|
					domain_expertise = Com::Nbos::StartupFundraising::domainExpertise.where(name: de["name"]).first
					@member.profile.domain_expertises << domain_expertise if domain_expertise.present?
				end
			end

			if @member.profile.update_columns(profile_params) && @member.save
				render :json => @member
			else
				render :json => {status: 500, message: @member.errors.messages}, status: 404
			end
		else
			render :json => {status: 404, message: "User Not Found"}, status: 404
		end
	end

	def get_tenant_info
		if @token_details.present?
			render :json => {tenantId: @token_details.tenantId}
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
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

			if user_params[:areaofInterests].present?
				company_categories = []
				user_params[:areaofInterests].each do |ai|
					area_of_interest = Com::Nbos::StartupFundraising::CompanyCategory.where(name: ai["name"]).first
					company_categories << area_of_interest if area_of_interest.present?
				end
					profile.company_categories = company_categories
			end

			if user_params[:domainExpertises].present?
				domain_expertises = []
				user_params[:domainExpertises].each do |de|
					domain_expertise = Com::Nbos::StartupFundraising::DomainExpertise.where(name: de["name"]).first
					domain_expertises << domain_expertise if domain_expertise.present?
				end
					profile.domain_expertises = domain_expertises
			end

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