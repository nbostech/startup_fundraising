class Com::Nbos::StartupFundraising::CompanyExecutiveSummary < ActiveRecord::Base
	belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
	belongs_to :company_summary_type, class_name: "Com::Nbos::StartupFundraising::CompanySummaryType"
end
