module AcceptsHelper
  def return_get_path
    path = Rails.application.routes.recognize_path(request.referer)
    case path
    when 'notifications'
      return_path = notifications_path
    when 'volunteers', 'join_volunteers'
      return_path = volunteer_join_index_path(@volunteer.id)
    else
      return_path = volunteer_join_index_path(@volunteer.id)
    end
    return_path
  end

  def approver_verification
    return true if @account.id == @volunteer.postable_id && @account.type == @volunteer.postable_type
  end
end
