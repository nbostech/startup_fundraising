module Com
  module Nbos
    module StartupFundraising
			class AnnualFinancialInfo < ActiveRecord::Base
        belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
        has_many :annual_financial_details, class_name: "Com::Nbos::StartupFundraising::AnnualFinancialDetail"
			end
	  end
	end
end		
