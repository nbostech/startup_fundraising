class Api::StartupFundraising::V0::StartupBaseController < ApplicationController
	  respond_to :json, :xml
	  skip_before_filter :verify_authenticity_token
	  before_action :header_authentication

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
