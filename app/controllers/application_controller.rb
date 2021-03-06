class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception, :except => :routing_error
	before_action :check_server_connection!, :get_initial_client_auth_token

	# To handle routing error
	def routing_error(error = 'Routing error', status = :not_found, exception=nil)
		render :json => {status: 404, message: "Endpoint Not Found"}, status: 404
	end

	private

	def header_authentication
		token = request.headers.env["HTTP_AUTHORIZATION"]
		if token.present? && token.split(" ")[1].present?
			true
		else
			render :json => {status: 401, message: "Unauthorized Access."}
		end
	end
		
	def get_initial_client_auth_token
		req = getAuthApi.get_auth_token("client_credentials", [])
		if req[:status] == 200
			@auth_token = req[:token].value
		else
			@auth_token = nil
		end
	end

	def get_member
		if @token_details.present? && @token_details.username.present?
			@member = Com::Nbos::User.where(uuid: @token_details.uuid).first
			if @member.present?
				@member
			elsif @token_details.present?
				@member = Com::Nbos::User.new()
				@member.uuid = @token_details.uuid
				@member.tenant_id = @token_details.tenantId
			else
				render :json => {status: 401, message: "Unauthorized"}, status: 401
			end
		else
			render :json => {status: 401, message: "Unauthorized"}, status: 401   
		end
	end

	def getAuthApi
		WavelabsClientApi::Client::Api::Core::AuthApi.new
	end

	def getUsersApi
		WavelabsClientApi::Client::Api::Core::UsersApi.new
	end

	def getSocialApi
		WavelabsClientApi::Client::Api::Core::SocialApi.new
	end

	def getMediaApi
		WavelabsClientApi::Client::Api::Core::MediaApi.new
	end

	def create_basic_login_model
	 WavelabsClientApi::Client::Api::DataModels::LoginApiModel.new
	end

	def create_member_model(sign_up_params, except_token)
		WavelabsClientApi::Client::Api::DataModels::MemberApiModel.new(sign_up_params, except_token) 
	end

	def create_media_model(media_params)
		WavelabsClientApi::Client::Api::DataModels::MediaApiModel.new(media_params) 
	end

	def check_server_connection!
		if WavelabsClientApi::Client::Api::Core::BaseApi.check_connection?
			true
		else
			flash[:notice] = "The Wavelabs Api server is down please try after sometime."
		end
	end
		
end
