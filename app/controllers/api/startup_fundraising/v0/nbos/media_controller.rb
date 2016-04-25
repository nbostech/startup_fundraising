class Api::StartupFundraising::V0::Nbos::MediaController < Api::StartupFundraising::V0::StartupBaseController

 before_action :validate_token

 def add_media
 	 if params[:media_for].present?
 	 	  @model = get_class_for_media(params[:media_for], params[:id])
     if @model
       @model.image = params[:image_file]
       if @model.save
         render :json => {status: 200, message: "Image uploaded successfully"}
       else
         render :json => {status: 200, message: @modal.errors.messages}
       end
     else
     	 render :json => {status: 400, message: "Unsupported Entity to upload Media"}
     end	
 	 else
 	 	 render :json => {status: 400, message: "Bad Request"}
 	 end	
 end

 def get_class_for_media(media_for, id)
 	case media_for
  when "company"
    Com::Nbos::StartupFundraising::Company.find(id).company_profile
  when "event"
    Com::Nbos::Events::Event.find(id)
  else
    false  
  end
 end

end	