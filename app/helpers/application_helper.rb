module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'Communiteer'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def return_path_get
    path = Rails.application.routes.recognize_path(request.referer)
    # binding.pry
    if path[:controller] == 'notifications'
      return_path = notifications_path
    elsif path[:controller] == 'volunteers'
      return_path = params[:page]
    elsif path[:controller] == 'join_volunteers'|| path[:controller] == 'accepts'
      return_path = volunteer_join_index_path(params[:volunteer_id])
    else
      return_path = root_path
    end
    return_path
  end
end
