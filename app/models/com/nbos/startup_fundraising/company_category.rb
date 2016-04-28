module Com
  module Nbos
    module StartupFundraising
			class CompanyCategory < ActiveRecord::Base
				has_many :companies, class_name: "Com::Nbos::StartupFundraising::Company", dependent: :destroy
				
	      scope :active_categories, -> { where(is_active: true) }
	      scope :total, -> { all }
	      
	      validates :name, presence: true
	      validates :name, uniqueness: true



	      def as_json(options={})
					super(:only => [:id, :name])
			  end			

		  end
		end
	end
end		
