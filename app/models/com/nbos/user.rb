module Com
	module Nbos
		class User < ActiveRecord::Base
			#ActiveRecord::Base.include_root_in_json = false
			has_one :profile, class_name: "Com::Nbos::StartupFundraising::Profile", dependent: :destroy
			has_many :event_rsvps, class_name: "Com::Nbos::Events::EventRsvp", inverse_of: :user, dependent: :destroy
			has_many :events, through: :event_rsvps
			has_many :roles_users, class_name: "Com::Nbos::StartupFundraising::RolesUsers", inverse_of: :user, dependent: :destroy
			has_many :roles, through: :roles_users

			has_many :favourites, class_name: "Com::Nbos::StartupFundraising::Favourite", dependent: :destroy

			has_many :investments, class_name: "Com::Nbos::StartupFundraising::Investment", inverse_of: :user, dependent: :destroy

			has_many :companies_users, class_name: "Com::Nbos::StartupFundraising::CompaniesUsers"
			has_many :companies, through: :companies_users, class_name: "Com::Nbos::StartupFundraising::Company"

			scope :active_users, -> { where(is_public: true) }
			scope :approved_users, -> { where(is_approved: true)}
			scope :total, -> { all }
			scope :investors, -> { all.joins(:roles_users).where(roles_users: {role_id: 3} ) }
			scope :startups, -> { all.joins(:roles_users).where(roles_users: {role_id: 4} ) }
			scope :premium_investors, -> { all.joins(:roles_users).where(roles_users: {role_id: 2})}
			
			validates :uuid, :tenant_id, presence: true
			validates_associated :profile

			def self.getUsers(user_type, tenantId)
				role_id = Com::Nbos::StartupFundraising::Role.where(name: user_type).first.id
				users = active_users.where(tenant_id: tenantId).joins(:roles_users).where(roles_users: {role_id: role_id} )  
			end	

			def as_json(options={})
				super(:only => [:id, :uuid],
							:include => [:profile, :companies => {:include => [:company_profile], :only => [:id]}, :roles => {:only => [:name]}]
						 )
			end

		end
	end
end		
