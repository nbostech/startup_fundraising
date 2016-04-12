namespace :startup do
  desc 'Create a Startup & Investor User'
  task add_users: :environment do
    token = WavelabsClientApi::Client::Api::Core::AuthApi.new.get_auth_token("client_credentials", [])	
    investor_params = { :username => "investor10", 
	                      :password => "test123",
	                      :email => "investor10@50knetwork.com",
	                      :full_name => "first investor",
	                      :firstName => "IN",
	                      :phone => "1234567890",
	                      :company => "Wavelabs"
	                    }

	  startup_params = {  :username => "startup10", 
	                      :password => "test123",
	                      :email => "startup10@50knetwork.com",
	                      :full_name => "first startup",
	                      :firstName => "ST",
	                      :phone => "1234567891",
	                      :startup_name => "Wavelabs Startup"
	                    }

    req = WavelabsClientApi::Client::Api::Core::UsersApi.new()
    new_investor = req.sign_up(investor_params, token[:token].value)
    new_startup = req.sign_up(startup_params, token[:token].value)
    m_token = WavelabsClientApi::Client::Api::Core::AuthApi.new().get_auth_token("client_credentials", "scope:oauth.token.verify", ENV["MODULE_API_SERVER_CLIENT_ID"], ENV["MODULE_API_SERVER_CLIENT_SECRET"]) 
    token_res1 = WavelabsClientApi::Client::Api::Core::AuthApi.new().is_token_valid(new_investor[:member].token.value, m_token[:token].value)
    #Creating New Investor

     member1 = Com::Nbos::User.new 
		 member1.uuid = token_res1[:token].uuid
		 member1.tenant_id = token_res1[:token].tenantId
		 
		 profile1 = Com::Nbos::StartupFundraising::Profile.new
		 profile1.email = investor_params[:email]
		 profile1.contact_number = investor_params[:phone]

		 api_response = WavelabsClientApi::Client::Api::Core::MediaApi.new().get_media(43, "profile", new_investor[:member].token.value)
		 if api_response[:status] == 200
			media = api_response[:media]
			profile1_image_path = media.mediaFileDetailsList[1].to_h["mediapath"]
			profile1.idn_image_url = profile1_image_path
		 end

		 member1.is_public = true
		 member1.is_authorized = false
		 investor_role = Com::Nbos::StartupFundraising::Role.where(code: "inv").first
		 member1.roles << investor_role
		 profile1.full_name = investor_params[:full_name]
		 profile1.company_name = investor_params[:company]
		 member1.profile = profile1

		 if member1.save
		 	puts "Investor created Successfully."
		 end
     
     #Creating New startup
     token_res2 = WavelabsClientApi::Client::Api::Core::AuthApi.new().is_token_valid(new_startup[:member].token.value, m_token[:token].value)
		 member2 = Com::Nbos::StartupFundraising::Company.new 
		 member2.uuid = token_res2[:token].uuid
		 member2.tenant_id = token_res2[:token].tenantId
		 
		 profile2 = Com::Nbos::StartupFundraising::CompanyProfile.new
		 profile2.email = startup_params[:email]
		 profile2.contact_number = startup_params[:phone]

		 api_response = WavelabsClientApi::Client::Api::Core::MediaApi.new().get_media(new_startup[:member].id, "profile", new_startup[:member].token.value)
		 if api_response[:status] == 200
			media = api_response[:media]
			profile2_image_path = media.mediaFileDetailsList[1].to_h["mediapath"]
			profile2.idn_image_url = profile2_image_path
		 end

		 member2.is_public = true
		 member2.is_authorized = false
		 profile2.full_name = startup_params[:full_name]
		 profile2.startup_name = startup_params[:startup_name]
		 member2.company_profile = profile2

		 if member2.save
		 	puts "Strtup created Successfully."
		 end
		 

  end
end