module Com
  module Nbos
    module StartupFundraising
			class Category < ActiveRecord::Base
				has_many :companies, class_name: "Com::Nbos::StartupFundraising::Company", dependent: :destroy
				
	      scope :active_categories, -> { where(is_active: true) }
	      scope :total, -> { all }
	      
	      validates :name, presence: true
	      validates :name, uniqueness: true

		  end
		end
	end
end		
