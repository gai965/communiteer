

class Users::RegistrationsController < Devise::RegistrationsController
  def reject
    redirect_to new_user_registration_path
  end

  #アカウント登録後のリダイレクト先
  def after_sign_up_path_for(resource)
    root_path
  end
end
