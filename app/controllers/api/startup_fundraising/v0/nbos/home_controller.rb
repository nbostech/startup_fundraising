class Api::StartupFundraising::V0::Nbos::HomeController < Api::StartupFundraising::V0::StartupBaseController
	
	 # Method to Return content about 50k network 
	 def about
		 #tenantId = params[:tenant_id]
		 #if tenantId.present?
			 @about_50k = "<p>50k Network is a part of 50k Ventures, which is a networkof high net worth individuals, accredited investors, and accomplished mentors.Diveded into different and quite diverse chapters, 50K Network caters to those who participate and contribute their share to the startup ecosystem in terms of funding, mentoring and providing strategic support for the growth and development of startups.</p>
                     <p>To be a part of this much coveted circle, one has to meet the criteria.</p>
                     <p>Right now, 50K Circle is spread actively in Hyderabad and Mumbai. However, we intend to spread our chapters all across the country soon.</p>"
			 render :json => @about_50k
		 #else
			# render :json => {status: 400, message: "Bad Request"}
		 #end	
	 end	

end	