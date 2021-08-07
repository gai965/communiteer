module VolunteersHelper
  def return_volunteer_path
    path = Rails.application.routes.recognize_path(request.referer)
    case path
    when 'notifications'
      notifications_path
    when 'accepts', 'volunteers'
      params[:page]
    when 'join_volunteers'
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
