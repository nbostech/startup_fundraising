module Com
	module Nbos
		module StartupFundraising
			class AnnualFinancialDetail < ActiveRecord::Base
				belongs_to :annual_financial_details, class_name: "Com::Nbos::StartupFundraising::AnnualFinancialDetail"
			end
		end
	end
end