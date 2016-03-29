module Com
  module Nbos
    module StartupFundraising	
			class Favourite < ActiveRecord::Base
			  belongs_to :favourited, polymorphic: true
			  belongs_to :user, class_name: "Com::Nbos::User"
			end
		end
	end
end				