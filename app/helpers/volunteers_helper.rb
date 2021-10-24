module VolunteersHelper
  def return_volunteer_path
    path = Rails.application.routes.recognize_path(request.referer)
    case path[:controller]
    when 'notifications'
      notifications_path
    when 'accepts', 'volunteers'
      volunteers_path
    when 'join_volunteers'
      request.referer
    when 'pages'
      request.referer
    else
      root_path
    end
  end
end
