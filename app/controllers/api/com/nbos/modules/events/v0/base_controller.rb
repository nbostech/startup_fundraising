class Api::Com::Nbos::Modules::Events::V0::BaseController < ApplicationController
  skip_before_action :check_server_connection!, :get_initial_client_auth_token
  skip_before_filter :verify_authenticity_token
  before_action :has_authorization, :get_identity_api
  # Before action to verify the token subscription & validation
  before_action do
    # module Name should be identical with the name of module
    # in dev.nbos.in & also maintain the same name in config/idn_config.yml
    # file while configuring module details
    module_verify("RoR-events")
  end

  private

  # This will check every request if the Authorization
  # Bearer header has value or not
  def has_authorization
    token = request.headers.env["HTTP_AUTHORIZATION"]
    if token.present? && token.split(" ")[1].present?
      @access_token = token.split(" ")[1]
    else
      render :json => {messsageCode: "Unauthorized Access", message: "Unauthorized Access"}, status: 401
    end
  end

  # This method is to check module subscription of the requested token.
  # And also enable the Redis cache based on configuration in config/application.yml
  def module_verify(moduleName)
    if !request.options?
      if @access_token.present?
        if ENV["CACHE_ENABLED"] == "true"
          cache_module_token_verify_details(moduleName)
        else
          @module_token_details = get_module_token_details(moduleName)
        end
        if @module_token_details.present?
          verify_module_token(moduleName)
          find_or_create_user
        end
      else
        render :json => {messageCode: "Unauthorized", message: "Unauthorized Access."}, status: 401
      end
    else
      return true
    end  
  end

  # Tis method is to set & get module token details from Redis Server
  def cache_module_token_verify_details(moduleName)
    begin
      module_token_details = $redis.get(@access_token + moduleName)
      if module_token_details.nil?
        @module_token_details = get_module_token_details(moduleName)
        $redis.set(@access_token + moduleName, @module_token_details.to_json)
        expire_time = ENV["CACHE_EXPIRE_TIME"].present? ? ENV["CACHE_EXPIRE_TIME"].to_i.minutes : 1.hour
        $redis.expire(@access_token, expire_time)
      else
        @module_token_details = IdnSdkRuby::Com::Nbos::Capi::Modules::Identity::V0::ModuleTokenApiModel.new(JSON.load(module_token_details))
        @module_token_details.uuid = JSON.load(module_token_details)["uuid"]
      end
    rescue RuntimeError => e
      render :json => {messageCode: "internal.server.error", message: e.message}, status: 500
    end
  end

  # This method is to get the module token verify details
  # using identity api tokenVerify method based on module
  # configuration in config/idn_config.yml
  def get_module_token_details(moduleName)
    module_token = get_module_token(moduleName)
    module_key = CONFIG["modules"]["#{moduleName}"]["module_key"]
    token_details = @identity_api.tokenVerify(module_token, @access_token, module_key)
    return token_details[:data]
  end

  # This method will check whether requested token is expired or not
  # And subscribed to perticular module or not
  def verify_module_token(moduleName)
    if @module_token_details.modules.present? && @module_token_details.get_modules.include?(moduleName)
      if @module_token_details.message.present?
        msg = @module_token_details.message
        render json: {"messageCode": "#{msg}", "message": "#{msg}"}
      elsif @module_token_details.expired
        render json: {"messageCode": "token.expired", "message": "Token Expired"}
      else
        true
      end
    else
      render json: {"messageCode": "module.unauthorized", "message": "You are not SubScrided To #{moduleName} Module"}
    end
  end

  # This method will create identity_api object
  # which will be used to interact with NBOS IDN API server
  def get_identity_api
    @identity_api = IdnSdkRuby::Com::Nbos::Capi::Modules::Ids::V0::Ids.getModuleApi("identity")
  end

  # This method is to generate the model validation
  # error message response
  def add_error_messages(obj)
    errors = []
    obj.errors.messages.each do |msg|
      m_arry = msg.to_a
      errors << {"messageCode": "#{obj.model_name.element}.#{m_arry[0]}",
          "message": "#{m_arry[0]} empty",
          "propertyName": "#{m_arry[0]}",
          "objectName": "#{obj.model_name}"}
    end
    {"errors": errors}
  end

  # This method will create user & tenant records
  # based on token details.
  def find_or_create_user
    user = ::Com::Nbos::User.where(uuid: @module_token_details.uuid)
    if user.present?
      @user = user.first
    elsif @module_token_details.uuid.present?
      @user = ::Com::Nbos::User.new
      @user.uuid = @module_token_details.uuid
      @user.tenant_id = @module_token_details.tenantId
      @user.save
    else
      @user = Com::Nbos::User.new
      @user.uuid = "guest"
      @user.tenant_id = @module_token_details.tenantId
    end
  end

  # This method will create module specific IDN context
  # and register the module with IDS & return the access token
  def get_module_token(moduleName)
    api_context = IdnAppContext.new("api")
    api_context.setClientCredentials(moduleName)
    token_model = IdnSdkRuby::Com::Nbos::Capi::Api::V0::IdnSDK.init(api_context, CONFIG["modules"]["#{moduleName}"]["scope"])
    token_model.access_token
  end

end