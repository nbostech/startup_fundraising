class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   
  before_action :header_authentication, :get_initial_client_auth_token, :get_module_auth_token

  private

  def header_authentication
    token = request.headers.env["HTTP_AUTHORIZATION"]
    if token.present? && token.split(" ")[1].present?
      true
    else
      render :json => {status: 401, message: "Unautherized Access."}
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

  def get_module_auth_token
   req = getAuthApi.get_auth_token("client_credentials", "scope:oauth.token.verify", ENV["MODULE_API_SERVER_CLIENT_ID"], ENV["MODULE_API_SERVER_CLIENT_SECRET"])
    if req[:status] == 200
      @module_auth_token = req[:token].value
    else
      @module_auth_token = nil
    end                
  end

  def validate_token
    token = request.headers.env["HTTP_AUTHORIZATION"]
    if token.present? && @module_auth_token.present?
      token_id = token.split(" ")[1]
      res = getAuthApi.is_token_valid(token_id, @module_auth_token)
      if res[:status] == 200
        @token_details = res[:token]
        if !res[:token].expired
          true
        else
          render :json => {status: res[:status], message: "Token Expired"}
        end  
      else
        render :json => {status: res[:status], message: res[:token].message}
      end
    else
      render :json => {status: 400, message: "Bad Request"}
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
