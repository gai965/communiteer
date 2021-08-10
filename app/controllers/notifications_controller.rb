class NotificationsController < ApplicationController
  before_action :set_login_account, only: [:index]
  before_action :move_to_top,       only: [:index]
  before_action :set_header_info,   only: [:index]

  def index
    @notifications = @account.passive_notifications.page(params[:page]).per(6)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
