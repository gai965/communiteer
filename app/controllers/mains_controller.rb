class MainsController < ApplicationController
  before_action :set_login_user, only: [:index]

  def index
    @volunteer = Volunteer.order('created_at DESC').limit(10)
    $volunteer_post_number = @volunteer.count
    $noimage_path = File.expand_path('app/assets/images/noimage.png', Rails.root)
  end

  # 新規登録・ログインの選択画面遷移---
  def sign_up_choice
  end

  def sign_in_choice
  end
  # ------------------------------

  def set_login_user
    if user_signed_in? 
      $login_name = current_user.nickname
      $icon_image_path = '/assets/user_icon.png'
      $logout_link_path = destroy_user_session_path
    elsif group_signed_in?
      $login_name = current_group.name
      $icon_image_path = '/assets/group_icon.png'
      $logout_link_path = destroy_group_session_path
    end
  end

end
