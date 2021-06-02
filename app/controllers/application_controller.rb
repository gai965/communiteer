class ApplicationController < ActionController::Base

  def set_login_account
    if user_signed_in?
      @account = current_user
      @account_type = 'User'
    elsif group_signed_in?
      @account = current_group
      @account_type = 'Group'
    end
  end
end
