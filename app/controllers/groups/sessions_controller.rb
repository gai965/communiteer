class Groups::SessionsController < Devise::SessionsController
  # ゲスト団体ログイン
  def guest_sign_in
    group = Group.guest
    sign_in group
    redirect_to root_path
  end

  # ログイン後にログイン画面にリダイレクトした場合
  def after_sign_in_path_for(_resource)
    root_path
  end
end
