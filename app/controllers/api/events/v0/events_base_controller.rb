class Api::Events::V0::EventsBaseController < ApplicationController
	  respond_to :json, :xml
	  before_action :header_authentication
	  skip_before_filter :verify_authenticity_token
end	
