class Com::Nbos::StartupFundraising::CompanySummaryType < ActiveRecord::Base
	def as_json(options={})
    super(:only => [:id, :name])
	end
end
