class VolunteersController < ApplicationController
  def new
    redirect_to mains_sign_in_choice_path unless user_signed_in? || group_signed_in?
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
    params.require(:volunteer).permit(:image, :title, :place, :details, :schedule, :start_time, :end_time, :expenses,
                                      :application_people, :conditions, :deadline)
  end
end
