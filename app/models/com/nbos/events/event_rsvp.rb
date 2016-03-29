module Com
  module Nbos
    module Events	
			class EventRsvp < ActiveRecord::Base
				belongs_to :user, class_name: "Com::Nbos::User" 
				belongs_to :event, class_name: "Com::Nbos::Events::Event"
			end
		end
	end
end				