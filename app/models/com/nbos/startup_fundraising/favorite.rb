module Com
	module Nbos
		module StartupFundraising	
			class Favorite < ActiveRecord::Base
				belongs_to :favoritable, polymorphic: true
				belongs_to :user, class_name: "Com::Nbos::User"

				validates :user_id, uniqueness: { scope: [:favoritable_id, :favoritable_type],
																					message: 'can only favorite a company once'
																				}

				scope :companies, -> { where(favoritable_type: 'Com::Nbos::StartupFundraising::Company') }																
			end
		end
	end
end				