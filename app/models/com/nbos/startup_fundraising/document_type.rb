module Com
	module Nbos
		module StartupFundraising
			class DocumentType < ActiveRecord::Base
				
				def as_json(options={})
					super(:only => [:id, :name])
				end
			end
		end
	end
end