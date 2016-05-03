module Com
  module Nbos
    module StartupFundraising
			class Address < ActiveRecord::Base
				belongs_to :address_type, class_name: "Com::Nbos::StartupFundraising::AddressType"
				belongs_to :addressable, polymorphic: true
        
        def address_type
        	self.address_type.name
        end

				def as_json(options={})
					super(:except => [:address_type_id, :created_at, :updated_at], 
								:methods => [:address_category]
					     )
				end
		  end
		end
	end
end		
