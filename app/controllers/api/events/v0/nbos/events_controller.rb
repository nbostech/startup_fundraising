class Api::Events::V0::Nbos::EventsController < Api::Events::V0::EventsBaseController
	
	before_action :validate_token

	 # Method to Return all events in a Tenant
	 def index
		 tenantId = params[:tenantId]
		 if tenantId.present?
			 @events = Com::Nbos::Events::Event.active_events.where(tenant_id: tenantId).page(params[:page])
			 paginate json: @events, per_page: params[:per_page]
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end

	 # Method to show an event in a Tenant
	 def show
		 tenantId = params[:tenantId]
		 event_id = params[:id]
		 if tenantId.present? && event_id.present?
			 @event = Com::Nbos::Events::Event.active_events.where("tenant_id = ? AND id = ?", tenantId, event_id)
			 render :json => @event
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end

end	