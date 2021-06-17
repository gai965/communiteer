module JoinVolunteersHelper
  def return_joinvolunteer_path
    volunteer_path(@volunteer.id, page: params[:second_pre_page])
  end
end
