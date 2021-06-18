module VolunteersHelper
  def return_volunteer_path
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == 'notifications'
      notifications_path
    elsif path[:controller] == 'accepts' || path[:controller] == 'volunteers'
      params[:page]
    elsif path[:controller] == 'join_volunteers'
      if params[:page].present?
        params[:page]
      else
        root_path
      end
    else
      root_path
    end
  end
end
