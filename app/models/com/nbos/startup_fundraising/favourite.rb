module Com
	module Nbos
		module StartupFundraising	
			class Favourite < ActiveRecord::Base
				belongs_to :favouritable, polymorphic: true
				belongs_to :user, class_name: "Com::Nbos::User" , inverse_of: :favourites

				validates :user_id, uniqueness: { scope: [:favouritable_id, :favouritable_type],
																					message: 'can only favourite a company once'
																				}

				scope :companies, -> { where(favoritable_type: 'Com::Nbos::StartupFundraising::Company') }																
			end
		end
	end
end				