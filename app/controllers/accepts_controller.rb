class AcceptsController < ApplicationController
  before_action :move_to_index,           only: [:join_volunteer_info]
  before_action :set_join_volunteer_info, only: [:join_volunteer_info, :join_volunteer_accept]

  def join_volunteer_info
  end

  def join_volunteer_accept
    @join_volunteer.create_notification_accept_registration!(@join_volunteer, @account)
    if @join_volunteer.accept_flag == false
      @join_volunteer.accept_flag = true
      redirect_to volunteer_accepts_join_info_path(@volunteer.id) if @join_volunteer.save!
    end
  end

  def set_join_volunteer_info
    set_login_account
    @volunteer = Volunteer.find(params[:volunteer_id])
    @join_volunteer = JoinVolunteer.find_by(volunteer_id: params[:volunteer_id])
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? || group_signed_in?
  end
end
