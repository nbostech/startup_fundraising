module Com
	module Nbos
		module StartupFundraising
			class DomainExpertise < ActiveRecord::Base
				has_many	:sub_domain_expertises, class_name: "DomainExpertise", foreign_key: "parent_id"
				belongs_to	:parent, class_name: "DomainExpertise"
				def as_json(options={})
					super(:only => [:id, :name, :parent_id])
				end
			end
		end
	end
end