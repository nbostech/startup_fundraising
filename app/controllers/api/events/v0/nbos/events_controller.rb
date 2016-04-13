class Api::Events::V0::Nbos::EventsController < Api::Events::V0::EventsBaseController
	
	before_action :validate_token

	 # Method to Return all investors & startups
	 # based on user_type & tenant query params
	 def index
		 tenantId = params[:tenantId]
		 if tenantId.present?
			 @events = Com::Nbos::Events::Event.active_events.where(tenant_id: tenantId).page(params[:page])
			 paginate json: @events, per_page: params[:per_page] || 5
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end

end	