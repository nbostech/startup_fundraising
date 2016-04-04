module Com
  module Nbos
    module StartupFundraising
  		class Company < ActiveRecord::Base
  			has_one :company_profile, class_name: "Com::Nbos::StartupFundraising::CompanyProfile", dependent: :destroy
  			

        has_many :favourites, as: :favouritable, class_name: "Com::Nbos::StartupFundraising::Favourite"
       
        belongs_to :category, class_name: "Com::Nbos::StartupFundraising::Category"
        
        belongs_to :company_stage, class_name: "Com::Nbos::StartupFundraising::CompanyStage"

        has_many :current_funding_rounds, class_name: "Com::Nbos::StartupFundraising::CurrentFundingRound", dependent: :destroy
  			
        scope :active_companies, -> { where(is_active: true) }
        scope :total, -> { all }
        
        validates :uuid, :tenant_id, presence: true
        validates_associated :company_profile

  		end
	  end
  end
end		
