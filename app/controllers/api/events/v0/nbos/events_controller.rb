class Api::Events::V0::Nbos::EventsController < Api::Events::V0::EventsBaseController
	
	before_action :validate_with_event_module_token
	before_action :get_member, only: [:create, :add_rsvp]

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

	# Method to show an event in a Tenant
	def update
		event_id = params[:id]
		if event_id.present? && params[:event].present?
			event_params = params[:event]
			@event = Com::Nbos::Events::Event.where(:id => event_id).first
			if @event.present? 
				@event.update(event_params.permit!)
				if @event.save
					render :json => @event
				else
					render :json => {status: 500, message: @event.errors.messages}, status: 500
				end
			else
				render :json => {status: 404, message: "Event Not Found"}, status: 404
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end
	end

	def create
		if params[:event].present? && @member.present?
			event_params = params[:event]
			@event = Com::Nbos::Events::Event.new(event_params.permit!)
			@event.user_id = @member.id if @member.id.present?
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

	def add_rsvp
		event_id = params[:id]
		if event_id.present? && @member.present?
			@event = Com::Nbos::Events::Event.where(:id => event_id).first
			if @event.present? 
				event_rsvp = Com::Events::EventRsvp.new()
				event_rsvp.user_id = @member.id if @member.id.present?
				event_rsvp.uuid = @member.uuid
				event_rsvp.event_id = @event.id
				event_rsvp.rsvp_type = "Attend" 
				if event_rsvp.save
					render :json => @event
				else
					render :json => {status: 500, message: event_rsvp.errors.messages}, status: 500
				end
			else
				render :json => {status: 404, message: "Event Not Found"}, status: 404
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end
	end

end