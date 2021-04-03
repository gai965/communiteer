
class Users::SessionsController < Devise::SessionsController

  # ゲストユーザログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path
  end

  # ログイン後にログイン画面にリダイレクトした場合
  def after_sign_in_path_for(resource)
    root_path
  end
end
