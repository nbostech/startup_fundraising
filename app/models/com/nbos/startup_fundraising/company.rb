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

				attr_accessor :company_stage, :category_name, :company_image_url


				def company_stage
					self.company_stage.name if self.company_stage_id.present?
				end

				def category_name
					self.category.name if self.category_id.present?
				end

				def company_image_url
					if Rails.env == "development"
			 	  	host = "http://localhost:3000"
			 	  else
			 	  	host = "https://startup-50k.herokuapp.com"
			 	  end 	
			 	  host + company_profile.image.url(:medium)
				end   

				def as_json(options={})
					super(:only => [:id],
						    :include => :company_profile, 
								:methods => [:company_stage, :category_name, :company_image_url]
					     )
				end 

			end 
		end
	end
end		
