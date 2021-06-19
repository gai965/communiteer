class MainsController < ApplicationController
  before_action :set_login_account,     only: [:set_header_info, :index]
  before_action :set_header_info,       only: [:index]
  before_action :deadline_verification, only: [:index]

  def index
    volunteers_set
    $noimage_path = File.expand_path('app/assets/images/noimage.png', Rails.root)
  end

  # 新規登録・ログインの選択画面遷移---
  def sign_up_choice
  end

  def sign_in_choice
  end
  # ------------------------------

  private

  def volunteers_set
    @volunteers = Volunteer.order('created_at DESC').limit(10)
    volunteers_path = []
    @volunteers.each do |volunteer|
      volunteers_path.push(volunteer_path(volunteer.id))
      volunteer.set_volunteer_noimage(volunteer.image)
    end
    @volunteers_path = volunteers_path
    @volunteer_post_number = @volunteers.count
  end

  def set_header_info
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
