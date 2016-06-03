module Com
	module Nbos
		module StartupFundraising
			class Company < ActiveRecord::Base
				has_one :company_profile, class_name: "Com::Nbos::StartupFundraising::CompanyProfile", dependent: :destroy
				

				has_many :favorites, as: :favoritable, class_name: "Com::Nbos::StartupFundraising::Favorite", dependent: :destroy
			 
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

				def profile
					self.company_profile
				end

				def logoImage
					self.assets.where(img_type: "logo").first
				end

				def brandImage
					self.assets.where(img_type: "brand").first
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

				def fundingRounds
					self.funding_rounds
				end   

				def as_json(options={})
					super(:only => [:id], 
								:methods => [:profile, :logoImage, :brandImage, :addressList, 
									           :descriptinList, :documentsList, :associates, :fundingRounds]
					     )
				end 

			end 
		end
	end
end		
