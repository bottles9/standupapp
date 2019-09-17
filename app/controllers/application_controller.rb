class ApplicationController < ActionController::Base

  include StandupsHelper

rescue_from CanCan::AccessDenied do |exception|
redirect_to root_url, :error => exception.message
end
add_flash_types :error

  before_action :authenticate_user!
  before_action :subscription_check

  layout :layout_by_resource
  
  helper_method :current_account
  helper_method :current_date
  helper_method :notification_standups
  helper_method :current_subscription


  def current_account
@current_account ||= current_user.account
@current_account
end

  def current_subscription
@current_subscription ||= current_user&.account&.subscription
@current_subscription
end

  def current_date
session[:current_date] =
session[:current_date] || Date.today.strftime('%a %d %b %Y')
@current_date ||= session[:current_date]
end

  def visible_teams
@visible_teams ||=
if current_user.has_role? :admin
current_account.teams.includes(:users)
else
current_user.teams.includes(:users)
end
@visible_teams
end
protected

    def layout_by_resource
      if devise_controller?
        'devise'
      else
        'application'
      end
    end

    def subscription_check
return if layout_by_resource == 'devise' ||
controller_name.in?(%w[plans billing accounts]) ||
current_subscription&.active?
if current_user.has_role? :admin, current_account
redirect_to(billing_index_path, notice: 'There is no valid subscription')
else
sign_out current_user
end
end
end
