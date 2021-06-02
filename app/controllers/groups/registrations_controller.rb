class Groups::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def reject
    redirect_to new_group_registration_path
  end

  # アカウント登録後のリダイレクト先
  def after_sign_up_path_for(_resource)
    root_path
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number, :base_address, :url, :group_category])
  end
end
