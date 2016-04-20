namespace :startup do
  desc 'Create Events'
  task create_events: :environment do
  	role = Com::Nbos::StartupFundraising::Role.where(code: "md").first
  	user_profile = Com::Nbos::StartupFundraising::Profile.where(email: 'admin@50knetwork.com').first
    (1..10).each do |e|  
	    events_params = { :name => "Event #{e}", 
		                    :description => "event #{e}",
		                    :address => "Madhapure, Hyderabad",
		                    :start_date => Time.now.to_date,
		                    :start_time => Time.now,
		                    :end_time => Time.now,
		                    :location => "Hyderabad #{e}",
		                    :user_id => user_profile.user_id,
		                    :contact_person => "moderator@50knetwork.com",
		                    :contact_number => "1234567890",
		                    :website => "http://50kventures.com",
		                    :tenant_id => user_profile.user.tenant_id,
		                    :is_public => true,
		                    :is_active => true
		                  }
		  event = Com::Nbos::Events::Event.create(events_params)                
    end
  end
end