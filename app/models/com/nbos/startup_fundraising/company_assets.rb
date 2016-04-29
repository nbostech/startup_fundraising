module Com
  module Nbos
    module StartupFundraising	
			class CompanyAssets < ActiveRecord::Base
         belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
         belongs_to :asset, class_name: "Com::Nbos::StartupFundraising::Asset"
			end
		end
	end
end			
