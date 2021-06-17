module VolunteersHelper

  def return_volunteer_path
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == 'notifications'
      return_path = notifications_path
    elsif path[:controller] == 'accepts' || path[:controller] == 'volunteers'
      return_path = params[:page]
    elsif path[:controller] == 'join_volunteers'
      if params[:page].present?
        return_path = params[:page]
      else
        return_path = root_path
      end
    else
      return_path = root_path
    end
    return_path
  end
end
