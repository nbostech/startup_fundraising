module Com
	module Nbos
		module StartupFundraising	
			class CompanyProfile < ActiveRecord::Base
				belongs_to :company, class_name: "Com::Nbos::StartupFundraising::Company"

				validates :email, :startup_name, :contact_number, presence: true

				def company_stage
					self.company.company_stage.name if self.company.company_stage.present?
				end

				def company_category
					self.company.company_category.name if self.company.company_category.present?
				end

				def currency_type
					self.company.currency_type.code if self.company.currency_type.present?
				end

				def as_json(options={})
					super(:except => [:company_id, :updated_at, :created_at], :methods => [:company_category, :company_stage, :currency_type])
				end
			end
		end
	end
end