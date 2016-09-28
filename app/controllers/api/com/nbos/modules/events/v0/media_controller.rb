class Api::Com::Nbos::Modules::Events::V0::MediaController < Api::Com::Nbos::Modules::Events::V0::BaseController

  def add_media
    if params[:media_for].present? && params[:id].present?
      @model = get_class_for_media(params[:media_for], params[:id])
      if @model[:status] == 200
        @model[:obj].image = params[:image_file]
        if @model[:obj].save
          render :json => @model[:obj]
        else
          data = add_error_messages(@model[:obj])
          render :json => data
        end
      else
        render :json => {messageCode: "unsupported.mediatype", message: @model[:message]},status: @model[:status]
      end
    else
      render :json => {messageCode: "bad.request", message: "Bad Request"}, status: 400
    end
  end

  def get_media
    if params[:id].present?
      @media = Com::Nbos::Events::EventAsset.where(id: params[:id]).first
      if @media.present?
        render :json => @media
      else
        render :json => {messsageCode: "media.notfound", message: "Media Not Found"},status: 404
      end
    else
      render :json => {messageCode: "bad.request", message: "Bad Request"}, status: 400
    end
  end

  def get_class_for_media(media_for, id)
    case media_for
      when "event"
        event = Com::Nbos::Events::Event.where(id: id, tenant_id: @module_token_details.tenantId).first
        if event.present?
          event_asset = event.event_assets.where(img_type: "event").first
          media_obj = event_asset.present? ? event_asset : event.event_assets.build(img_type: "event")
          {status: 200, obj: media_obj}
        else
          {status: 404, message: "Event Not Found to Add Image."}
        end
      else
        {status: 500, message: "Unsupported mediafor #{media_for}"}
    end
  end

end