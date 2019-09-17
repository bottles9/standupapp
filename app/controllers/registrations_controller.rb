class RegistrationsController < Devise::RegistrationsController
before_action :configure_permitted_parameters, if: :devise_controller?

protected
def configure_permitted_parameters
devise_parameter_sanitizer.permit(:sign_up) do |user_params| 
  user_params.permit({roles: []}, :name, :email, :password, :password_confirmation )
end
end
def after_sign_up_path_for(resource)
  new_accounts_path(plan: params[:plan])
end
end
