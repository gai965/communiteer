module NotificationsHelper
  def unchecked_notification
    @notifications_unread = @account.passive_notifications.find_by(checked: false)
  end
end
