RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.main_app_name = ["50k Network", "Administration"]

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      only ['Com::Nbos::Events::Event', 'Com::Nbos::StartupFundraising::Role', 
            'Com::Nbos::StartupFundraising::Investment',
            'Com::Nbos::StartupFundraising::CompanyStage',
            'Com::Nbos::StartupFundraising::CompanyCategory',
            'Com::Nbos::StartupFundraising::CurrentFundingRound',
            'Com::Nbos::StartupFundraising::AddressType',
            'Com::Nbos::StartupFundraising::AssociateTeam',
            'Com::Nbos::StartupFundraising::CompanySummaryType',
            'Com::Nbos::StartupFundraising::CuurencyType',
            'Com::Nbos::StartupFundraising::DomainExpertise',
            'Com::Nbos::StartupFundraising::DocumentType'
          ]
    end  
    export
    bulk_delete
    show
    edit
    delete do
      only ['Com::Nbos::Events::Event', 'Com::Nbos::StartupFundraising::Role', 
            'Com::Nbos::StartupFundraising::Investment',
            'Com::Nbos::StartupFundraising::CompanyStage',
            'Com::Nbos::StartupFundraising::CompanyCategory',
            'Com::Nbos::StartupFundraising::CurrentFundingRound',
            'Com::Nbos::StartupFundraising::AddressType',
            'Com::Nbos::StartupFundraising::AssociateTeam',
            'Com::Nbos::StartupFundraising::CompanySummaryType',
            'Com::Nbos::StartupFundraising::CuurencyType',
            'Com::Nbos::StartupFundraising::DomainExpertise',
            'Com::Nbos::StartupFundraising::DocumentType'            
          ]
    end  
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  # Excluded Models from Rails Admin Navigation
  ["Com::Nbos::StartupFundraising::RolesUsers", "Com::Nbos::Events::EventRsvp", 
   "Com::Nbos::StartupFundraising::Favorite", "Com::Nbos::StartupFundraising::CompaniesUsers",
   "Com::Nbos::StartupFundraising::Address", "Com::Nbos::StartupFundraising::AddressType",
   "Com::Nbos::StartupFundraising::AnnualFinancialDetail",
   "Com::Nbos::StartupFundraising::AnnualFinancialInfo", 
   "Com::Nbos::StartupFundraising::CompanyExicutiveSummary",
   "Com::Nbos::StartupFundraising::CompanySummaryType",
   "Com::Nbos::StartupFundraising::Document", "Com::Nbos::StartupFundraising::DocumentType"].each do |m|
    config.excluded_models << m
  end

  #External logout link in navigation  
  config.navigation_static_links = {
  'LogOut' => '/logout'
  }

  #User model configuration
  config.model Com::Nbos::User do
    navigation_icon 'icon-user'
    list do
      scopes [:total, :active_users, :investors, :startups,:premium_investors]
      field :id
      field :is_public
      field :email do
        pretty_value do
          user_p = bindings[:object].profile
          user_p.email
        end
      end
      field :full_name do
        pretty_value do
          user_p = bindings[:object].profile
          user_p.full_name
        end
      end
      field :user_type do
        pretty_value do
          user_r = bindings[:object].roles.first
          user_r.name
        end
      end 
      field :created_at
    end 

    show do
      field :id
      field :uuid
      field :tenant_id
      field :is_public
      field :created_at
      field :updated_at
    end

    edit do
      exclude_fields :favorites, :events, :event_rsvps, :investments, :current_funding_rounds
      field :uuid do
        read_only true
      end
      field :tenant_id do
        read_only true
      end  
    end  
  end 

  config.model Com::Nbos::StartupFundraising::Role do
    navigation_icon 'icon-user'
  end

  config.model Com::Nbos::StartupFundraising::Profile do
    navigation_icon 'icon-user'
  end

  config.model Com::Nbos::Events::Event do
    navigation_icon 'icon-calendar'
  end

  #Custom Authentication 
  require "rails_admin/application_controller"

  module RailsAdmin
    class ApplicationController < ::ApplicationController
      before_filter :require_admin

      private
      def require_admin
        if session[:admin_user].present?
          true
        else
          redirect_to main_app.com_nbos_admin_login_path
        end  
      end 
    end
  end


  #Overriding rails admin view helpers

  require "rails_admin/application_helper"
    module RailsAdmin
      module ApplicationHelper
        def static_navigation
          li_stack = RailsAdmin::Config.navigation_static_links.collect do |title, url|
            content_tag(:li, link_to(title.to_s, url))
          end.join

          label = RailsAdmin::Config.navigation_static_label || t('admin.misc.navigation_static_label')
          li_stack = %(<li class='dropdown-header'>#{label}</li>#{li_stack}).html_safe if li_stack.present?
          li_stack
        end
      end
    end    

end
