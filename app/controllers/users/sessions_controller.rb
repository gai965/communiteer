
class Users::SessionsController < Devise::SessionsController

  # ログイン後にログイン画面にリダイレクトした場合
  def after_sign_in_path_for(resource)
    root_path
  end
end
