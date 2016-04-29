module Com
	module Nbos
		module StartupFundraising
			class Company < ActiveRecord::Base
				has_one :company_profile, class_name: "Com::Nbos::StartupFundraising::CompanyProfile", dependent: :destroy
				

				has_many :favourites, as: :favouritable, class_name: "Com::Nbos::StartupFundraising::Favourite"
			 
				belongs_to :company_category, class_name: "Com::Nbos::StartupFundraising::CompanyCategory"
				
				belongs_to :company_stage, class_name: "Com::Nbos::StartupFundraising::CompanyStage"

				has_many :funding_rounds, class_name: "Com::Nbos::StartupFundraising::FundingRound", dependent: :destroy

				has_many :companies_users, class_name: "Com::Nbos::StartupFundraising::CompaniesUsers"
				has_many :users, through: :companies_users, class_name: "Com::Nbos::User"

				belongs_to :currency_type

        has_many :company_associates, class_name: "Com::Nbos::StartupFundraising::CompanyAssociate"
				has_many :company_documents, class_name: "Com::Nbos::StartupFundraising::CompanyDocument"
				
				has_many :company_executive_summaries, class_name: "Com::Nbos::StartupFundraising::CompanyExecutiveSummary"

				has_many :addresses_companies, class_name:"Com::Nbos::StartupFundraising::AddressesCompanies"
				has_many :addresses , through: :addresses_companies, class_name:"Com::Nbos::StartupFundraising::Address"
				
				has_many :company_assets, class_name:"Com::Nbos::StartupFundraising::CompanyAsset"
				has_many :assets, class_name:"Com::Nbos::StartupFundraising::Asset"
				
				scope :active_companies, -> { where(is_approved: true) }
				scope :total, -> { all }
				
				validates :uuid, :tenant_id, presence: true
				validates_associated :company_profile

				attr_accessor :company_stage, :category_name, :company_image_url


				def company_stage
					self.company_stage.name if self.company_stage_id.present?
				end

				def category_name
					self.company_category.name if self.category_id.present?
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
						    :include => {:company_profile => {:except => [:created_at, :updated_at, :document_file_name,
						    	           :document_content_type, :document_file_size, :document_updated_at,
						    	           :image_file_name, :image_content_type, :image_file_size, :image_updated_at,
						    	           :company_id, :company_category_id, :company_stage_id]}}, 
								:methods => [:company_stage, :category_name, :company_image_url]
					     )
				end 

			end 
		end
	end
end		
