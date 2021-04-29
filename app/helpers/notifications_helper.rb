module NotificationsHelper
  def unchecked_notifications
    if user_signed_in?
      @notifications_unread = current_user.passive_notifications.where(checked: false)
    elsif group_signed_in?
      @notifications_unread = current_group.passive_notifications.where(checked: false)
    end
  end
end
