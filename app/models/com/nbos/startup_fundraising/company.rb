module Com
  module Nbos
    module StartupFundraising
  		class Company < ActiveRecord::Base
  			has_one :company_profile, class_name: "Com::Nbos::StartupFundraising::CompanyProfile", dependent: :destroy
  			

        has_many :favourites, as: :favouritable, class_name: "Com::Nbos::StartupFundraising::Favourite"
       
        belongs_to :category, class_name: "Com::Nbos::StartupFundraising::Category"
        
        belongs_to :company_stage, class_name: "Com::Nbos::StartupFundraising::CompanyStage"

        has_many :funding_rounds, class_name: "Com::Nbos::StartupFundraising::FundingRound", dependent: :destroy

        scope :active_companies, -> { where(is_public: true) }
        scope :total, -> { all }
        
        validates :uuid, :tenant_id, presence: true
        validates_associated :company_profile

        def self.getCompanies(tenantId)
          companies = active_companies.where(tenant_id: tenantId)
        end

        def self.getCompaniesList(tenantId, companyType)
          if companyType == "portfolio"
            startups = active_companies.where(tenant_id: tenantId).joins(:company_profile).where(company_profiles: {is_funded: true} )  
          elsif companyType == "deal_bank"
            startups = []
          elsif companyType == "funding_progress"
            startups = []
          end 
        end 
        
        def self.get_company_profiles(companies)
          company_profiles = []

          companies.each do |c|
            company_profiles << c.company_profile 
          end

          company_profiles 
        end

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
