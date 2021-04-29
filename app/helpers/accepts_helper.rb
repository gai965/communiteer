module AcceptsHelper
  def volunteer_post_name_get
    volunteer_post_name = Volunteer.find(params[:volunteer_id])
    return volunteer_post_name.postable.contributor_name
  end

  def volunteer_title_get
    volunteer_title = Volunteer.select(:title).find(params[:volunteer_id])
    return volunteer_title.title
  end

  def volunteer_root_path_get
    volunteer_root_path = Volunteer.select(:id).find(params[:volunteer_id])
    return volunteer_path(volunteer_root_path.id)
  end
  
  def approver_verification
    if @account_info.id == @volunteer.postable_id && @account_type == @volunteer.postable_type
      return true
    end
  end
end
