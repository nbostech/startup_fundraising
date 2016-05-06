class Api::StartupFundraising::V0::Nbos::AssociatesController < Api::StartupFundraising::V0::StartupBaseController
 
 before_action :validate_token
 
  
  def index
    if params[:id].present?
    	@company = Com::Nbos::StartupFundraising::Company.where(id: params[:id]).first
    	if @company.present?
    		render :json => @company.company_associates
      else
      	render :json => {status: 404, message: "Company Not Found"}
      end		
    else
    	render :json => {status: 400, message: "Bad Request"}
    end	
  end

  def create
     if params[:id].present?
       company = Com::Nbos::StartupFundraising::Company.where(id: params[:id]).first
       if company.present? 
	       associated_team_type = Com::Nbos::StartupFundraising::AssociateTeam.where(name: params[:associate_type]).first if params[:associate_type].present?
         associate_params = params[:associate].except(:associate_type)
         @team_member = Com::Nbos::StartupFundraising::CompanyAssociate.new(associate_params.permit!)
	       @team_member.associate_team_id = associated_team_type.present? ? associated_team_type.id : nil
	       @team_member.company_id = company.id
	       if @team_member.save
	         render :json => @team_member
	       else
	         render :json => {status: 500, message: @team_member.errors.messages}
	       end
       else
       	 render :json => {status: 404, message: "Company Not Found"}
       end   
     else
       render :json => {status: 400, message: "Bad Request"}
     end   
  end

  def show
    if params[:id].present?
       @company_associate = Com::Nbos::StartupFundraising::CompanyAssociate.where(id: params[:id]).first
       if @company_associate.present?  
	      render :json => @company_associate
       else
       	 render :json => {status: 404, message: "Associate Not Found"}
       end   
     else
       render :json => {status: 400, message: "Bad Request"}
     end
  end
  
  def update_associate
  	if params[:id].present?
       @company_associate = Com::Nbos::StartupFundraising::CompanyAssociate.where(id: params[:id]).first
       associate_params = params[:associate].except(:associate_type)
       if params[:associate_type].present? 
         associated_team_type = Com::Nbos::StartupFundraising::AssociateTeam.where(name: params[:associate_type]).first 
         associate_params.merge(associate_type_id: associated_team_type.id)
       end
       if @company_associate.update_columns(associate_params.permit!) 
	       render :json => @company_associate
       else
       	 render :json => {status: 404, message: "Associate Not Found"}
       end   
     else
       render :json => {status: 400, message: "Bad Request"}
     end
  end

  def delete
  	if params[:id].present?
       @company_associate = Com::Nbos::StartupFundraising::CompanyAssociate.where(id: params[:id]).first
       if @company_associate.destroy  
	       render :json => {status: 200, message: "Associate Deleted Successfully"}
       else
       	 render :json => {status: 404, message: "Associate Not Found"}
       end   
     else
       render :json => {status: 400, message: "Bad Request"}
     end
  end	

end