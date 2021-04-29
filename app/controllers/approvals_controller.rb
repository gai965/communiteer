class ApprovalsController < ApplicationController
 
  def join_volunteer_info
    @join_volunteer_info = JoinVolunteer.find(params[:volunteer_id])
  end

end
