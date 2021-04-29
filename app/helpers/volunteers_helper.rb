module VolunteersHelper

  def return_path_get
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == 'notifications'
      return_path = notifications_path
    elsif path[:controller] == 'approvals'
      volunteer_root_path = Volunteer.where(id: params[:id]).select(:id)
      return_path = volunteer_approvals_join_info_path(volunteer_root_path[0][:id])
    else
      return_path = root_path
    end
    return return_path
  end
  
end
