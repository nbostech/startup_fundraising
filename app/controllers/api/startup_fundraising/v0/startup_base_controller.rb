class Api::StartupFundraising::V0::StartupBaseController < ApplicationController
	
	respond_to :json, :xml
	skip_before_filter :verify_authenticity_token
	#before_action :header_authentication
	before_action :get_fundr_module_auth_token, :validate_with_fundr_module_token

	def get_fundr_module_auth_token
		req = getAuthApi.get_auth_token("client_credentials", "scope:oauth.token.verify", ENV["FUNDR_MODULE_API_SERVER_CLIENT_ID"], ENV["FUNDR_MODULE_API_SERVER_CLIENT_SECRET"])
		if req[:status] == 200
			@fundr_module_auth_token = req[:token].value
		else
			@fundr_module_auth_token = nil
		end
	end

	def validate_with_fundr_module_token
		token = request.headers.env["HTTP_AUTHORIZATION"]
		if token.present? && @fundr_module_auth_token.present?
			token_id = token.split(" ")[1]
			res = token_id.present? ? getAuthApi.is_token_valid(token_id, @fundr_module_auth_token) : { status: -1, message: "Invalid Token" }
			if res[:status] == 200
				@token_details = res[:token]
				if !res[:token].expired
					true
				else
					render :json => {status: res[:status], message: "Token Expired"}, status: res[:status]
				end
			elsif res[:status] == -1
				render :json => {status: res[:status], message: res[:message]}, status: res[:status]
			else
				render :json => {status: res[:status], message: res[:token].message}, status: res[:status]
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
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

end