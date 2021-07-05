class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def reject
    redirect_to new_user_registration_path
  end

  # アカウント登録後のリダイレクト先
  def after_sign_up_path_for(_resource)
    root_path
  end

  private

  # ユーザ新規登録時の情報を確認
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :type])
  end
end
