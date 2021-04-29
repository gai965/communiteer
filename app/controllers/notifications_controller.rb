class NotificationsController < ApplicationController
  before_action :move_to_index,     only: [:index]
  before_action :set_login_account, only: [:index]
 
  def index
    @notifications = @account.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def move_to_index
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
