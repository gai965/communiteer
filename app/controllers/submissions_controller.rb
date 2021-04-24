class SubmissionsController < ApplicationController

  def join_volunteer_new
    @volunteer = Volunteer.find(params[:volunteer_id])
    @join_volunteer = JoinVolunteer.new
  end

  def join_volunteer_create
    @volunteer = Volunteer.find(params[:volunteer_id])
    @join_volunteer = JoinVolunteer.new(join_volunteer_params)
    
    if @join_volunteer.save
      redirect_to volunteer_path(@volunteer.id)
    else
      render :join_volunteer_new
    end
  end

  private
  def join_volunteer_params
    params.require(:join_volunteer).permit(:name, :phone_number, :number, :inquir).merge(user_id: current_user.id, volunteer_id: @volunteer.id)
  end
end
