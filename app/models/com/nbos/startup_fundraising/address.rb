module Com
  module Nbos
    module StartupFundraising
			class Address < ActiveRecord::Base
				belongs_to :address_type, class_name: "Com::Nbos::StartupFundraising::AddressType"
				belongs_to :addressable, polymorphic: true
		  end
		end
	end
end		
