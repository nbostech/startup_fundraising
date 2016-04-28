module Com
	module Nbos
		module StartupFundraising
			class CurrencyType < ActiveRecord::Base
       
        def as_json(options={})
					super(:only => [:id, :code])
			  end	 
			end 
		end
	end
end		
