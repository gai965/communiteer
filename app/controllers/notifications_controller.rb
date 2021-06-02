class NotificationsController < ApplicationController
  before_action :move_to_index,     only: [:index]

  def index
    set_login_account
    @notifications = @account.passive_notifications.page(params[:page]).per(6)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? || group_signed_in?
  end
end