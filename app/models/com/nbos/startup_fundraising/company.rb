module Com
	module Nbos
		module StartupFundraising
			class Company < ActiveRecord::Base
				has_one :company_profile, class_name: "Com::Nbos::StartupFundraising::CompanyProfile", dependent: :destroy
				

				has_many :favourites, as: :favouritable, class_name: "Com::Nbos::StartupFundraising::Favourite"
			 
				belongs_to :category, class_name: "Com::Nbos::StartupFundraising::Category"
				
				belongs_to :company_stage, class_name: "Com::Nbos::StartupFundraising::CompanyStage"

				has_many :funding_rounds, class_name: "Com::Nbos::StartupFundraising::FundingRound", dependent: :destroy

				has_many :companies_users, class_name: "Com::Nbos::StartupFundraising::CompaniesUsers"
				has_many :users, through: :companies_users, class_name: "Com::Nbos::User"
				
				scope :active_companies, -> { where(is_public: true) }
				scope :total, -> { all }
				
				validates :uuid, :tenant_id, presence: true
				validates_associated :company_profile 

				def as_json(options={})
					super(:only => [:id, :uuid],
								:include => {
									:company_profile => {:only => [:full_name, :email, :contact_number]}
								}
					)
				end 

			end 
		end
	end
end		
