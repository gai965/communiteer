module JoinVolunteersHelper
  def return_get_path
    path = Rails.application.routes.recognize_path(request.referer)
    case path[:controller]
    when 'notifications'
      notifications_path
    when 'volunteers', 'join_volunteers'
      volunteer_join_index_path(@volunteer.id)
    else
      volunteer_join_index_path(@volunteer.id)
    end
  end

  def return_joinvolunteer_path
    volunteer_path(@volunteer.id, page: params[:second_pre_page])
  end

  def volunteer_post_name_get
    volunteer_post_name = Volunteer.find(params[:volunteer_id])
    volunteer_post_name.postable.contributor_name
  end

  def volunteer_title_get
    volunteer_title = Volunteer.select(:title).find(params[:volunteer_id])
    volunteer_title.title
  end

  def volunteer_root_path_get
    volunteer_root_path = Volunteer.select(:id).find(params[:volunteer_id])
    volunteer_path(volunteer_root_path.id, page: request.original_url)
  end
end
