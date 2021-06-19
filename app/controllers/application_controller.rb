class ApplicationController < ActionController::Base
  def move_to_login
    redirect_to mains_sign_in_choice_path unless user_signed_in? || group_signed_in?
  end

  def move_to_top
    redirect_to root_path unless user_signed_in? || group_signed_in?
  end

  private

  def set_login_account
    if user_signed_in?
      @account = current_user
    elsif group_signed_in?
      @account = current_group
    end
  end
end
