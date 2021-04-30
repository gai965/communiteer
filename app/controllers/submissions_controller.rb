class SubmissionsController < ApplicationController
  before_action :move_to_index,     only: [:join_volunteer_new]
  before_action :set_login_account, only: [:index]

  def join_volunteer_new
    @volunteer = Volunteer.find(params[:volunteer_id])

    @join_volunteer = if params[:name].present?
                        JoinVolunteer.new(name: params[:name], phone_number: params[:phone_number])
                      else
                        JoinVolunteer.new
                      end
  end

  def join_volunteer_create
    @volunteer = Volunteer.find(params[:volunteer_id])
    @join_volunteer = JoinVolunteer.new(join_volunteer_params)
    set_login_account

    if @join_volunteer.save
      @join_volunteer.create_notification_join_registration!(@join_volunteer, @volunteer, @account_info)
      @volunteer.participant_number += @join_volunteer.number
      @volunteer.save
      redirect_to volunteer_path(@volunteer.id)
    else
      render :join_volunteer_new
    end
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? || group_signed_in?
  end

  private

  def join_volunteer_params
    params.require(:join_volunteer).permit(:name, :phone_number, :number, :inquiry).merge(volunteer_id: @volunteer.id)
  end

  def set_login_account
    if user_signed_in?
      @join_volunteer.joinable_id = current_user.id
      @join_volunteer.joinable_type = 'User'
      @account_info = current_user
    else
      @join_volunteer.joinable_id = current_group.id
      @join_volunteer.joinable_type = 'Group'
      @account_info = current_group
    end
  end
end
