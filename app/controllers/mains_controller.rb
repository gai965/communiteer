class MainsController < ApplicationController
  before_action :set_header_info, only: [:index]
  before_action :deadline_verification, only: [:index]

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

  def set_header_info
    set_login_account
    if user_signed_in?
      $login_id = current_user.id
      $icon_image_path = '/assets/user_icon.png'
      $logout_link_path = destroy_user_session_path
    elsif group_signed_in?
      $login_id = current_group.id
      $icon_image_path = '/assets/group_icon.png'
      $logout_link_path = destroy_group_session_path
    end
  end

  def deadline_verification
    @volunteer_deadline_over = Volunteer.where('deadline < ?', Time.current.yesterday).where(deadline_flag: false)
    @volunteer_deadline_over.each do |volunteer|
      volunteer.update(deadline_flag: true)
    end
  end
end
