module AcceptsHelper
  def return_get_path
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == 'notifications'
      return_path = notifications_path
    elsif path[:controller] == 'volunteers'|| path[:controller] == 'join_volunteers'
      return_path =  volunteer_join_index_path(@volunteer.id)
    elsif 
      return_path =  volunteer_join_index_path(@volunteer.id)
    end
    return_path
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
    volunteer_path(volunteer_root_path.id, page:request.original_url)
  end

  def approver_verification
    return true if @account.id == @volunteer.postable_id && @account_type == @volunteer.postable_type
  end
end
