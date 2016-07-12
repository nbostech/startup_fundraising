class Api::StartupFundraising::V0::Nbos::HomeController < Api::StartupFundraising::V0::StartupBaseController
	
	skip_before_filter :validate_with_fundr_module_token
	
	# Method to Return content about 50k network
	def about
		render :json =>  "http://50knetwork.com/about-us/"
	end

end