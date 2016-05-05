module Com
	module Nbos
		module StartupFundraising
			class Company < ActiveRecord::Base
				has_one :company_profile, class_name: "Com::Nbos::StartupFundraising::CompanyProfile", dependent: :destroy
				

				has_many :favourites, as: :favouritable, class_name: "Com::Nbos::StartupFundraising::Favourite", dependent: :destroy
			 
				belongs_to :company_category, class_name: "Com::Nbos::StartupFundraising::CompanyCategory"
				
				belongs_to :company_stage, class_name: "Com::Nbos::StartupFundraising::CompanyStage"

				has_many :funding_rounds, class_name: "Com::Nbos::StartupFundraising::FundingRound", dependent: :destroy

				has_many :companies_users, class_name: "Com::Nbos::StartupFundraising::CompaniesUsers", dependent: :destroy
				has_many :users, through: :companies_users, class_name: "Com::Nbos::User"

				belongs_to :currency_type, class_name: "Com::Nbos::StartupFundraising::CurrencyType"

        has_many :company_associates, class_name: "Com::Nbos::StartupFundraising::CompanyAssociate", dependent: :destroy
				has_many :documents, as: :attachable, class_name: "Com::Nbos::StartupFundraising::Document", dependent: :destroy
				
				has_many :company_executive_summaries, class_name: "Com::Nbos::StartupFundraising::CompanyExecutiveSummary", dependent: :destroy

				has_many :addresses , as: :addressable, class_name:"Com::Nbos::StartupFundraising::Address", dependent: :destroy
				
				has_many :assets, as: :imageable, class_name:"Com::Nbos::StartupFundraising::Asset", dependent: :destroy
				
				scope :active_companies, -> { where(is_approved: true) }
				scope :total, -> { all }
				
				validates_associated :company_profile

				attr_accessor :company_stage, :category_name, :company_image_url


				def company_stage
					self.company_stage.name if self.company_stage_id.present?
				end

				def category_name
					self.company_category.name if self.company_category_id.present?
				end

				def company_image_url
					if Rails.env == "development"
			 	  	host = "http://localhost:3000"
			 	  else
			 	  	host = "https://startup-50k.herokuapp.com"
			 	  end
			 	  url =  self.assets.present? ? self.assets.first.image.url(:medium) : "/images/default/missing_image.png"	
			 	  host + url
				end

				def profile
					self.company_profile
				end

				def logoImage
					self.assets.where(img_type: "logo")
				end

				def brandImage
					self.assets.where(img_type: "brand")
				end

				def addressList
					self.addresses
				end

				def descriptionList
					self.company_executive_summaries
				end

				def documentsList
					self.documents
				end

				def associates
					self.company_associates
				end   

				def as_json(options={})
					super(:only => [:id], 
								:methods => [:profile, :logoImage, :brandImage, :addressList, 
									           :descriptinList, :documentsList, :associates]
					     )
				end 

			end 
		end
	end
end		
