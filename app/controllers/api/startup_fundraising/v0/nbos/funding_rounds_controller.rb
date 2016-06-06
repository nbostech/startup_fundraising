class Api::StartupFundraising::V0::Nbos::FundingRoundsController < Api::StartupFundraising::V0::StartupBaseController
 
 before_action :validate_token
 before_action :get_member, only: [:index, :create, :update_fundingRound, :delete]
 
  
  def index
    if params[:id].present? && @member.present?
    	@company = @member.companies.where(id: params[:id]).first
    	if @company.present?
    		render :json => @company.funding_rounds
      else
      	render :json => {status: 404, message: "Company Not Found"}
      end		
    else
    	render :json => {status: 400, message: "Bad Request"}
    end	
  end

  def create
     if params[:id].present? && @member.present?
       @company = @member.companies.where(id: params[:id]).first
       if @company.present? 
         fundinground_params = params[:funding_round]
         @funding_round = Com::Nbos::StartupFundraising::FundingRound.new(fundinground_params.permit!)
	       @funding_round.company_id = @company.id
	   
	       if @funding_round.save
	         render :json => @company.funding_rounds
	       else
	         render :json => {status: 500, message: @funding_round.errors.messages}, status: 500
	       end
       else
       	 render :json => {status: 404, message: "Company Not Found"},status: 404
       end   
     else
       render :json => {status: 400, message: "Bad Request"},status: 400
     end   
  end

  def show
    if params[:id].present?
       @funding_round = Com::Nbos::StartupFundraising::FundingRound.where(id: params[:id]).first
       if @funding_round.present?  
	      render :json => @funding_round
       else
       	 render :json => {status: 404, message: "FundingRound Not Found"},status: 404
       end   
     else
       render :json => {status: 400, message: "Bad Request"}, status: 400
     end
  end
  
  def update_fundingRound
  	if params[:id].present? && @member.present?
       @funding_round = @member.funding_rounds.where(id: params[:id]).first
       funding_round_params = params[:funding_round]

       if @funding_round.update_columns(funding_round_params.permit!) 
	       render :json => @funding_round
       else
       	 render :json => {status: 404, message: "FundingRound Not Found"},status: 404
       end   
     else
       render :json => {status: 400, message: "Bad Request"},status: 400
     end
  end

  def delete
  	if params[:id].present? && && @member.present?
       @funding_round = @member.funding_rounds.where(id: params[:id]).first
       company_id = @funding_round.company_id if @funding_round.present?
       if @funding_round.destroy 
         @company = Com::Nbos::StartupFundraising::Company.where(id: company_id).first 
	       render :json => @company.funding_rounds
       else
       	 render :json => {status: 404, message: "FundingRound Not Found"}, status: 404
       end   
     else
       render :json => {status: 400, message: "Bad Request"},status: 400
     end
  end	

end