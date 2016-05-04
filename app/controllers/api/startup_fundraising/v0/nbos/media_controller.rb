class Api::StartupFundraising::V0::Nbos::MediaController < Api::StartupFundraising::V0::StartupBaseController

 before_action :validate_token

 def add_media
 	 if params[:media_for].present? && params[:id].present?
 	 	  @model = get_class_for_media(params[:media_for], params[:id])
     if @model[:status] == 200
       @model[:obj].image = params[:image_file]
       if @model[:obj].save
         render :json => @model[:obj]
       else
         render :json => {status: 500, message: @modal.errors.messages}
       end
     else
     	 render :json => {status: 400, message: @model[:message]}
     end	
 	 else
 	 	 render :json => {status: 400, message: "Bad Request"}
 	 end	
 end

 def get_media
   if params[:id].present?
     @media = Com::Nbos::StartupFundraising::Asset.where(id: params[:id]).first
     if @media.present?
       render :json => @media
     else
       render :json => {status: 404, message: "Media Not Found"}
     end 
   else
     render :json => {status: 400, message: "Bad Request"}
   end 
 end 

 def get_class_for_media(media_for, id)
 	case media_for
  when "company_logo"
    company = Com::Nbos::StartupFundraising::Company.where(id: id).first
    if company.present?
      media_obj = company.assets.where(img_type: "logo").first.present? ? company.assets.where(img_type: "logo").first : company.assets.build(img_type: "logo")
      {status: 200, obj: media_obj}
    else
      {status: 404, message: "Company Not Found to Add logo."}
    end    
  when "company_brand"
    company = Com::Nbos::StartupFundraising::Company.where(id: id).first
    if company.present?
      media_obj = company.assets.where(img_type: "brand").first.present? ? company.assets.where(img_type: "brand").first : company.assets.build(img_type: "brand")
      {status: 200, obj: media_obj}
    else
      {status: 404, message: "Company Not Found to Add Brand Image."}
    end
  else
    {status: 500, message: "Unsupported mediafor #{media_for}"}  
  end
 end

end	