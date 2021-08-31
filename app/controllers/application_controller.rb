class ApplicationController < ActionController::Base
  def move_to_login
    redirect_to mains_sign_in_choice_path if @account.blank?
  end

  def move_to_top
    redirect_to root_path if @account.blank?
  end

  private

  def set_login_account
    if user_signed_in?
      @account = current_user
    elsif group_signed_in?
      @account = current_group
    end
  end

  def set_header_info
    if user_signed_in?
      @icon_image_path = '/assets/user_icon.png'
      @logout_link_path = destroy_user_session_path
    elsif group_signed_in?
      @icon_image_path = '/assets/group_icon.png'
      @logout_link_path = destroy_group_session_path
    end
  end
end
