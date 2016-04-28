module Com
  module Nbos
    module StartupFundraising
			class CompanyDocumentCategory < ActiveRecord::Base
        
        def as_json(options={})
					super(:only => [:id, :name])
			  end	
		  end
		end
	end
end		
