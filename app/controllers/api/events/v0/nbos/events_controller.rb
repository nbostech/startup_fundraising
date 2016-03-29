class Api::Events::V0::Nbos::EventsController < Api::Events::V0::EventsBaseController
	
	before_action :validate_token

	 # Method to Return all investors & startups
	 # based on user_type & tenant query params
	 def index
		 tenantId = params[:tenant_id]
		 if tenantId.present?
			 events = Com::Nbos::Events::Event.active_events.where(tenant_id: tenantId).to_json
			 render :json => {status: 200, data: events}
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end

end	