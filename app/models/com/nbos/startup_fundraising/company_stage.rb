module Com
  module Nbos
    module StartupFundraising
  		class CompanyStage < ActiveRecord::Base
  			has_many :companies, class_name: "Com::Nbos::StartupFundraising::Company"

        validates :name, presence: true
        validates :name, uniqueness: true

  		end
	  end
  end
end		
