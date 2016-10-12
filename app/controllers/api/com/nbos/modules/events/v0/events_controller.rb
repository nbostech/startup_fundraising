class Api::Com::Nbos::Modules::Events::V0::EventsController < Api::Com::Nbos::Modules::Events::V0::BaseController
  
  skip_before_action :has_authorization, :only => [:cros_op]
  skip_before_action :get_identity_api, :only => [:cros_op]
  skip_before_action :only => [:cros_op] do
    module_verify("RoR-events")
  end


  # This method will return tenant based events
  # If the token is user token it will return user's todos
  # If the token is client token it will return it's tenant public todos
  def index
    tenantId = params[:tenantId]
    if tenantId.present?
      @events = Com::Nbos::Events::Event.active_events.where(tenant_id: tenantId).page(params[:page])
      paginate json: @events, per_page: params[:per_page]
    else
      render :json => {messageCode: "bad.request", message: "Bad Request"}, status: 400
    end
  end

  def cros_op
    render :json => {messageCode: "Success", message: "Success"}, status: 200
  end  


  # Method to get token based tenant events
  def get_events
    if @user.uuid.present?
      @events = @user.events.active_events.page(params[:page])
      paginate json: @events, per_page: params[:per_page]
    elsif @user.uuid == "guest"
      @events = Com::Nbos::Events::Event.active_events.where(tenant_id: @user.tenant_id)
      render json: @events
    else
      render :json => {messageCode: "bad.request", message: "Bad Request"}, status: 400
    end
  end

  # Method to show an event in a Tenant
  def show
    event_id = params[:id]
    if event_id.present?
      @event = Com::Nbos::Events::Event.active_events.where(id: event_id, tenant_id: @user.tenant_id)
      if @event.present?
        render :json => @event
      else
        render :json => {messageCode: "event.notfound", message: "Event Not Found"}, status: 404
      end
    else
      render :json => {messageCode: "bad.request", message: "Bad Request"}, status: 400
    end
  end

  # Method to update an event in a Tenant
  def update
    event_id = params[:id]
    if event_id.present? && params[:event].present? && @user.uuid.present? && @user.uuid != "guest"
      event_params = params[:event]
      @event = Com::Nbos::Events::Event.where(id: params[:id], user_id: @user.id ).first
      if @event.present?
        @event.update(event_params.permit!)
        if @event.save
          render :json => @event
        else
          data = add_error_messages(@event)
          render :json => data
        end
      else
        render :json => {"messageCode": "module.user.unauthorized", "message": "Unauthorized to update others Event"}, status: 404
      end
    else
      render :json => {messageCode: "bad.request", message: "Bad Request"}, status: 400
    end
  end

  def create
    if params[:event].present? && @user.uuid.present? && @user.uuid != "guest"
      event_params = params[:event]
      @event = Com::Nbos::Events::Event.new(event_params.permit!)
      @event.user_id = @user.id
      @event.uuid = @user.uuid
      @event.tenant_id = @user.tenant_id
      if @event.save
        render :json => @event
      else
        data = add_error_messages(@event)
        render :json => data
      end
    else
      render :json => {messageCode: "bad.request", message: "Bad Request"}, status: 400
    end
  end

  def add_rsvp
    event_id = params[:id]
    if event_id.present? && @user.uuid.present? && @user.uuid != "guest"
      @event = Com::Nbos::Events::Event.where(id: event_id, tenant_id: @user.tenant_id ).first
      if @event.present?
        event_rsvp = Com::Events::EventRsvp.new()
        event_rsvp.user_id = @user.id
        event_rsvp.uuid = @user.uuid
        event_rsvp.event_id = @event.id
        event_rsvp.rsvp_type = "Attend"
        if event_rsvp.save
          render :json => @event
        else
          data = add_error_messages(event_rsvp)
          render :json => data
        end
      else
        render :json => {messageCode: "event.notfound", message: "Event Not Found"}, status: 404
      end
    else
      render :json => {messageCode: "bad.request", message: "Bad Request"}, status: 400
    end
  end

end