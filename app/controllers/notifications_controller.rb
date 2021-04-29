class NotificationsController < ApplicationController
before_action :set_login_account, only: [:index]
 
  def index
    @notifications = @account.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
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
