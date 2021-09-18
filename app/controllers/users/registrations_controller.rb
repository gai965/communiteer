class Users::RegistrationsController < Devise::RegistrationsController
  before_action :set_login_account,              only: [:edit]
  before_action :configure_permitted_parameters, only: [:create, :update]

  def reject
    redirect_to new_user_registration_path
  end

  # アカウント登録後のリダイレクト先
  def after_sign_up_path_for(resource)
    root_path
  end

  def after_update_path_for(resource)
    page_path(resource, type: resource.type)
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :type])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:type])
  end

  def update_resource(resource, configure_permitted_parameters)
    resource.update_with_password(configure_permitted_parameters)
  end
end