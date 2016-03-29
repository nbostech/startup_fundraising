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
      only ['Com::Nbos::Events::Event', 'Com::Nbos::StartupFundraising::Role']
    end  
    export
    bulk_delete
    show
    edit
    delete do
      only ['Com::Nbos::Events::Event', 'Com::Nbos::StartupFundraising::Role']
    end  
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  # Excluded Models from RAils Admin Navigation
  ["Com::Nbos::StartupFundraising::UserRole", "Com::Nbos::StartupFundraising::Investment", "Com::Nbos::Events::EventRsvp", "Com::Nbos::StartupFundraising::Favourite"].each do |m|
    config.excluded_models << m
  end

  #External logout link in navigation  
  config.navigation_static_links = {
  'LogOut' => '/logout'
  }

  #User model configuration
  config.model Com::Nbos::User do
    list do
      field :id
      field :is_active
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
      field :is_active
      field :created_at
      field :updated_at
    end

    edit do
      exclude_fields :favourites, :events, :event_rsvps, :investments, :favourite_profiles
      field :uuid do
        read_only true
      end
      field :tenant_id do
        read_only true
      end  
    end  
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

end
