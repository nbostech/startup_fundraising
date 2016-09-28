class Api::Events::V0::EventsBaseController < ApplicationController
		
	respond_to :json, :xml
	#before_action :header_authentication
	skip_before_filter :verify_authenticity_token
	before_action :get_events_module_auth_token

	def get_events_module_auth_token
		req = getAuthApi.get_auth_token("client_credentials", "scope:oauth.token.verify", ENV["EVENTS_MODULE_API_SERVER_CLIENT_ID"], ENV["EVENTS_MODULE_API_SERVER_CLIENT_SECRET"])
		if req[:status] == 200
			@events_module_auth_token = req[:token].value
		else
			@events_module_auth_token = nil
		end
	end

	def validate_with_event_module_token
		token = request.headers.env["HTTP_AUTHORIZATION"]
		if token.present? && @events_module_auth_token.present?
			token_id = token.split(" ")[1]
			res = token_id.present? ? getAuthApi.is_token_valid(token_id, @events_module_auth_token, ENV['EVENTS_MODULE_M_KEY']) : { status: -1, message: "Invalid Token" }
			if res[:status] == 200
				@token_details = res[:token]
				if !res[:token].expired
					if  @token_details.modules.present? && @token_details.get_modules.include?("events")
						true
					else
						render json: {"messageCode": "module.unauthorized", "message": "You are not SubScrided To Events Module"}
					end
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
end