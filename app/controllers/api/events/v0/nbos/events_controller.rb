class Api::Events::V0::Nbos::EventsController < Api::Events::V0::EventsBaseController
	
	before_action :validate_token
	before_action :get_member, only: [:create]

	 # Method to Return all events in a Tenant
	 def index
		 tenantId = params[:tenantId]
		 if tenantId.present?
			 @events = Com::Nbos::Events::Event.active_events.where(tenant_id: tenantId).page(params[:page])
			 paginate json: @events, per_page: params[:per_page]
		 else
			 render :json => {status: 400, message: "Bad Request"}, status: 400
		 end	
	 end

	 # Method to get token based tenant events
	 def get_events
	 	if @token_details.present? && @token_details.tenantId.present?
			 @events = Com::Nbos::Events::Event.active_events.where(tenant_id: @token_details.tenantId).page(params[:page])
			 paginate json: @events, per_page: params[:per_page]
		 else
			 render :json => {status: 400, message: "Bad Request"}, status: 400
		 end	
	 end	

	 # Method to show an event in a Tenant
	 def show
		 event_id = params[:id]
		 if event_id.present?
			 @event = Com::Nbos::Events::Event.active_events.where(:id => event_id)
			 render :json => @event
		 else
			 render :json => {status: 400, message: "Bad Request"}, status: 400
		 end	
	 end

	 def create
	 	if params[:event].present? && @member.present?
	 		 event_params = params[:event]
       @event = Com::Nbos::Events::Event.new(event_params.permit!)
       @event.uuid = @member.uuid
       @event.tenant_id = @member.tenant_id
       if @event.save
          render :json => @event
       else
          render :json => {status: 500, message: @event.errors.messages}, status: 500
       end   
     else
       render :json => {status: 400, message: "Bad Request"}, status: 400
     end
	 end	

end	