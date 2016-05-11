class Api::StartupFundraising::V0::Nbos::FavoritesController < Api::StartupFundraising::V0::StartupBaseController

 before_action :validate_token

 def index
   if @token_details.uuid.present? && params[:favorite_type].present?
     investor = Com::Nbos::User.where(uuid: @token_details.uuid).first
     if investor.present?
     	 model = get_favoritable_model(params[:favorite_type])
     	 if model
         @favorite_startups_list = model.where(id: investor.favorites.pluck(:favoritable_id))
         render :json => @favorite_startups_list
       else
       	 render :json => {status: 404, message: "#{params[:favorite_type]} Favoirite Type Not Supported."}
       end  
     else
       render :json => {status: 404, message: "User not Found"}
     end  
   else
    render :json => {status: 400, message: "Bad Request"}
   end 
 end

 def create
	 if params[:id].present? && @token_details.uuid.present? && params[:favorite_type].present?
	   investor = Com::Nbos::User.where(uuid: @token_details.uuid).first
	   model = get_favoritable_model(params[:favorite_type])
	   if model
		   favoritable_model = model.where(id: params[:id]).first
		   add_to_favorite = Com::Nbos::StartupFundraising::Favorite.new(favoritable: favoritable_model, user: investor)
		   if add_to_favorite.save
		     @favorite_startups_list = model.where(id: investor.favorites.pluck(:favoritable_id))
		     render :json => @favorite_startups_list
		   else
		     render :json => {status: 404, message: add_to_favorite.errors.messages}
		   end
		 else
       render :json => {status: 404, message: "#{params[:favorite_type]} Favoirite Type Not Supported."}
     end      
	 else
	  render :json => {status: 400, message: "Bad Request"}
	 end 
 end

 def delete
   if params[:id].present? && @token_details.uuid.present? && params[:favorite_type].present?
     investor = Com::Nbos::User.where(uuid: @token_details.uuid).first
     model = get_favoritable_model(params[:favorite_type])
	   if model
	     favoritable_model = model.where(id: params[:id]).first
	     if investor.present? && favoritable_model.present? && investor.favorites.where(favoritable_id: favoritable_model.id).present?
	       favorite_startup = investor.favorites.where(favoritable_id: favoritable_model.id).first
	       favorite_startup.destroy
	       @favorite_startups_list = model.where(id: investor.favorites.pluck(:favoritable_id))
	       render :json => @favorite_startups_list
	     else
	       render :json => {status: 404, message: "Record not Found"}
	     end
     else
       render :json => {status: 404, message: "#{params[:favorite_type]} Favoirite Type Not Supported."}
     end   
   else
    render :json => {status: 400, message: "Bad Request"}
   end
 end

 def get_favoritable_model(type)
 	case type
  when "company"
  	Com::Nbos::StartupFundraising::Company
  else
  	return false
  end	
 end	

end 