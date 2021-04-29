module ApprovalsHelper
  def volunteer_title_get
    volunteer_title = Volunteer.where(id: params[:volunteer_id]).select(:title)
    return volunteer_title[0][:title]
  end

  def volunteer_root_path
    volunteer_root_path = Volunteer.where(id: params[:volunteer_id]).select(:id)
    return volunteer_path(volunteer_root_path[0][:id])
  end
end