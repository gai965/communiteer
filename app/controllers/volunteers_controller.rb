class VolunteersController < ApplicationController
  def new
    redirect_to root_path unless user_signed_in? || group_signed_in?
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    if user_signed_in?
      @volunteer.postable_id = current_user.id
      @volunteer.postable_type = 'User'
    else
      @volunteer.postable_id = current_group.id
      @volunteer.postable_type = 'Group'
    end
    if @volunteer.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:name, :place, :schedule, :details, :expenses, :conditions, :application_people, :deadline)
  end
end
