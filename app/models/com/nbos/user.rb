module Com
  module Nbos
		class User < ActiveRecord::Base
			has_one :profile, class_name: "Com::Nbos::StartupFundraising::Profile", dependent: :destroy
			has_many :event_rsvps, class_name: "Com::Nbos::Events::EventRsvp", inverse_of: :user, dependent: :destroy
			has_many :events, through: :event_rsvps
			has_many :user_roles, class_name: "Com::Nbos::StartupFundraising::UserRole", inverse_of: :user, dependent: :destroy
			has_many :roles, through: :user_roles
			has_many :favourites, class_name: "Com::Nbos::StartupFundraising::Favourite", inverse_of: :user, dependent: :destroy
			has_many :favourite_profiles, through: :favourites, source: :favourited, source_type: "Com::Nbos::StartupFundraising::Profile"
      has_many :investments, class_name: "Com::Nbos::StartupFundraising::Investment", inverse_of: :user, dependent: :destroy

      scope :active_users, -> { where(is_active: true) }

      def self.getUsers(user_type, tenantId)
      	role_id = Com::Nbos::StartupFundraising::Role.where(name: user_type).first.id
        users = active_users.where(tenant_id: tenantId).joins(:user_roles).where(user_roles: {role_id: role_id} ).to_json
        if users.present?
          get_profiles(users)
        else
        	[]
        end   
      end	

      def self.getPortfolio(tenantId)
      	role_id = Com::Nbos::StartupFundraising::Role.where(name: "startup").first.id
      	startups = active_users.where(tenant_id: tenantId).joins(:user_roles, :profile).where(user_roles: {role_id: role_id}, profiles: {is_funded: true} ).to_json
        if startups.present?
          get_profiles(startups)
        else
          []
        end  
      end

      def self.getDealbank(tenantId)
      	role_id = Com::Nbos::StartupFundraising::Role.where(name: "startup").first.id
      	startups = active_users.where(tenant_id: tenantId).joins(:user_roles, :profile).where(user_roles: {role_id: role_id}, profiles: {is_funded: false , current_fund: nil} ).to_json
        if startups.present?
        	get_profiles(startups)
        else
        	[]
        end 	
      end

      def getFundInProgress(tenantId)
        role_id = Com::Nbos::StartupFundraising::Role.where(name: "startup").first.id
      	startups = active_users.where(tenant_id: tenantId).joins(:user_roles, :profile).where(user_roles: {role_id: role_id}, profiles: {is_funded: true} ).to_json
        if startups.present?
        	get_profiles(startups)
        else
        	[]
        end 	
      end 	

      def self.get_profiles(members)
        user_profiles = []

        members.each do |m|
        	user_profiles << m.profile 
        end

        user_profiles	
      end	

		end
	end
end		
