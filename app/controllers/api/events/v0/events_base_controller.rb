class Api::Events::V0::EventsBaseController < ApplicationController
	  respond_to :json, :xml
	  before_action :header_authentication
end	
