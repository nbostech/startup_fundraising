class Api::StartupFundraising::V0::Nbos::HomeController < Api::StartupFundraising::V0::StartupBaseController
	
	 # Method to Return content about 50k network 
	 def about
		 tenantId = params[:tenant_id]
		 if tenantId.present?
			 about_50k = "About 50k Network"
			 render :json => {status: 200, data: about_50k}
		 else
			 render :json => {status: 400, message: "Bad Request"}
		 end	
	 end	

end	