module Com
  module Nbos
    module StartupFundraising
			class Address < ActiveRecord::Base
				belongs_to :address_type, class_name: "Com::Nbos::StartupFundraising::AddressType"
        
        def as_json(options={})
					super(:only => [:id, :name])
			  end	
		  end
		end
	end
end		
