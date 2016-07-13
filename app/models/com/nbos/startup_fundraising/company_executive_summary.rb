class Com::Nbos::StartupFundraising::CompanyExecutiveSummary < ActiveRecord::Base
	belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"
	belongs_to :company_summary_type, class_name: "Com::Nbos::StartupFundraising::CompanySummaryType"

	def description_type
		self.description_type.name
	end
		
	def as_json(options={})
		super(:only => [:id, :description], 
					:methods => [:description_type]
					)
	end
end