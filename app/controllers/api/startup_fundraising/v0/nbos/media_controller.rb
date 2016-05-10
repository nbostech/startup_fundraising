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
         render :json => {status: 500, message: @model[:obj].errors.messages}
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
      company_logo_asset = company.assets.where(img_type: "logo").first
      media_obj = company_logo_asset.present? ? company_logo_asset : company.assets.build(img_type: "logo")
      {status: 200, obj: media_obj}
    else
      {status: 404, message: "Company Not Found to Add logo."}
    end    
  when "company_brand"
    company = Com::Nbos::StartupFundraising::Company.where(id: id).first
    if company.present?
      company_brand_asset = company.assets.where(img_type: "brand").first
      media_obj = company_brand_asset.present? ? company_brand_asset : company.assets.build(img_type: "brand")
      {status: 200, obj: media_obj}
    else
      {status: 404, message: "Company Not Found to Add Brand Image."}
    end
  when "associate_profile"
    company_associate = Com::Nbos::StartupFundraising::CompanyAssociate.where(id: id).first
    if company_associate.present?
      associate_profile_asset = company_associate.assets.where(img_type: "associate_profile").first
      media_obj = associate_profile_asset.present? ? associate_profile_asset : company_associate.assets.build(img_type: "associate_profile")
      {status: 200, obj: media_obj}
    else
      {status: 404, message: "Associate Not Found to Add Profile Image."}
    end  
  else
    {status: 500, message: "Unsupported mediafor #{media_for}"}  
  end
 end

end	