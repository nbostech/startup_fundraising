namespace :startup do
  desc 'Create Moderator User'
  task create_moderator: :environment do
    token = WavelabsClientApi::Client::Api::Core::AuthApi.new.get_auth_token("client_credentials", [])
	    moderator_params = { :username => "moderator", 
		                      :password => "test123",
		                      :email => "moderator@50knetwork.com",
		                      :full_name => "moderator",
		                      :firstName => "MD",
		                      :phone => "1234567890",
		                      :company => "50k Network"
		                    }

	    req = WavelabsClientApi::Client::Api::Core::UsersApi.new()
	    new_moderator = req.sign_up(moderator_params, token[:token].value)
	    m_token = WavelabsClientApi::Client::Api::Core::AuthApi.new().get_auth_token("client_credentials", "scope:oauth.token.verify", ENV["MODULE_API_SERVER_CLIENT_ID"], ENV["MODULE_API_SERVER_CLIENT_SECRET"]) 
	    token_res1 = WavelabsClientApi::Client::Api::Core::AuthApi.new().is_token_valid(new_moderator[:member].token.value, m_token[:token].value)
	    #Creating New Moderator

	     member1 = Com::Nbos::User.new 
			 member1.uuid = token_res1[:token].uuid
			 member1.tenant_id = token_res1[:token].tenantId
			 
			 profile1 = Com::Nbos::StartupFundraising::Profile.new
			 profile1.email = moderator_params[:email]
			 profile1.contact_number = moderator_params[:phone]

			 api_response = WavelabsClientApi::Client::Api::Core::MediaApi.new().get_media(43, "profile", new_moderator[:member].token.value)
			 if api_response[:status] == 200
				media = api_response[:media]
				profile1_image_path = media.mediaFileDetailsList[1].to_h["mediapath"]
				profile1.idn_image_url = profile1_image_path
			 end

			 member1.is_public = true
			 member1.is_authorized = false
			 moderator_role = Com::Nbos::StartupFundraising::Role.where(code: "md").first
			 member1.roles << moderator_role
			 profile1.full_name = moderator_params[:full_name]
			 profile1.company_name = moderator_params[:company]
			 member1.profile = profile1

			 if member1.save
			 	puts "Moderator created Successfully."
			 end
  end
end