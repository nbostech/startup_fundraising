namespace :startup do
  desc 'Create Moderator User'
  task create_moderator: :environment do
    token = WavelabsClientApi::Client::Api::Core::AuthApi.new.get_auth_token("client_credentials", [])
	    moderator_params = {:username => "adminmoderator", 
		                      :password => "admin",
		                      :email => "admin@50knetwork.com",
		                      :full_name => "adminmoderator",
		                      :firstName => "MD",
		                      :lastName => "admin",
		                      :phone => "1234567890"
		                    }

	    req = WavelabsClientApi::Client::Api::Core::UsersApi.new()
	    new_moderator = req.sign_up(moderator_params, token[:token].value)
	    m_token = WavelabsClientApi::Client::Api::Core::AuthApi.new().get_auth_token("client_credentials", "scope:oauth.token.verify", ENV["MODULE_API_SERVER_CLIENT_ID"], ENV["MODULE_API_SERVER_CLIENT_SECRET"]) 
	    token_res1 = WavelabsClientApi::Client::Api::Core::AuthApi.new().is_token_valid(new_moderator[:member].token.value, m_token[:token].value)
	    
	    #Creating New Moderator

	     member1 = Com::Nbos::User.new 
			 member1.uuid = token_res1[:token].uuid
			 member1.tenant_id = token_res1[:token].tenantId
			 member1.is_public = true
			 member1.is_approved = true
			 
			 profile1 = Com::Nbos::StartupFundraising::Profile.new
			 profile1.email = moderator_params[:email]
			 profile1.contact_number = moderator_params[:phone]
       profile1.idn_image_url = profile1_image_path
       profile1.idn_image_url = ENV['IDN_HOST_URL'] + "/Media/default/default-profile_300x200.png"

       member1.profile = profile1

			 moderator_role = Com::Nbos::StartupFundraising::Role.where(code: "md").first
			 member1.roles << moderator_role
			 

			 if member1.save
			 	puts "Moderator created Successfully."
			 end
  end
end