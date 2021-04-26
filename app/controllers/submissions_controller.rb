class SubmissionsController < ApplicationController

  def join_volunteer_new
    @volunteer = Volunteer.find(params[:volunteer_id])

    if params[:name].present?
      @join_volunteer = JoinVolunteer.new(:name => params[:name], :phone_number => params[:phone_number])
    else
      @join_volunteer = JoinVolunteer.new
    end
  end

  def join_volunteer_create
    @volunteer = Volunteer.find(params[:volunteer_id])
    @join_volunteer = JoinVolunteer.new(join_volunteer_params)
    
    if user_signed_in?
      @join_volunteer.joinable_id = current_user.id
      @join_volunteer.joinable_type = 'User'
    else
      @join_volunteer.joinable_id = current_group.id
      @join_volunteer.joinable_type = 'Group'
    end

    if @join_volunteer.save
      @volunteer.participant_number += @join_volunteer.number
      @volunteer.save
      redirect_to volunteer_path(@volunteer.id)
    else
      render :join_volunteer_new
    end
  end

  private
  def join_volunteer_params
    params.require(:join_volunteer).permit(:name, :phone_number, :number, :inquir).merge(volunteer_id: @volunteer.id)
  end
end
