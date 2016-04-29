module Com
  module Nbos
    module StartupFundraising
			class AddressesCompanies < ActiveRecord::Base
				belongs_to :address, class_name: "Com::Nbos::StartupFundraising::Address"
        belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
        def as_json(options={})
					super(:only => [:id, :name])
			  end	
		  end
		end
	end
end		
