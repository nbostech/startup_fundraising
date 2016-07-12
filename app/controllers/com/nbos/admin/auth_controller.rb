
# This controller is responsible for handling 
# admin login ,logout, change_password & forgot_password
# requests with Wavelabes API Server

class Com::Nbos::Admin::AuthController < ApplicationController
	
	before_action :check_server_connection!, :only => [:login]

	def login
		@login = create_basic_login_model
		if request.post?
			api_response = getAuthApi.login(params[:wavelabs_client_api_client_api_data_models_login_api_model], @auth_token)
			if api_response[:status] == 200
				@member = api_response[:member]
				moderator = Com::Nbos::User.where(uuid: @member.uuid).first
				if moderator.present? && moderator.roles.first.name == "Moderator"
					session[:admin_user] = @member
					redirect_to :rails_admin
				else
					getAuthApi.logout(@member.token.value)
					flash[:notice] = "You are Not Authorized"
					render :login
				end
			else
				@login = api_response[:login]
				flash[:notice] = api_response[:login].message
				render :login
			end
		end
	end

	def change_password
		@login = create_basic_login_model
		if request.post?
			api_response = getAuthApi.change_password(params[:wavelabs_client_api_client_api_data_models_login_api_model], session[:auth_token])
			if api_response[:status] == 200 || api_response[:status] == 400
				@login = api_response[:login]
			else
				@login = api_response[:login]
			end
		end
	end

	def logout
		api_response = getAuthApi.logout(session[:admin_user]["token"]["value"])
		if api_response[:status] == 200
			flash[:notice] = api_response[:login].message
			session[:admin_user] = nil
			redirect_to :com_nbos_admin_login
		end
	end

	def forgot_password
		@login = create_basic_login_model
		if request.post?
			api_response = getAuthApi.forgot_password(params[:wavelabs_client_api_client_api_data_models_login_api_model], @auth_token)
			if api_response[:status] == 200
				flash[:notice] = api_response[:login].message + " To #{api_response[:login].email}"
				redirect_to :com_nbos_core_login
			else
				@login = api_response[:login]
				render :forgot_password
			end
		end
	end
end