class AcceptsController < ApplicationController
  before_action :move_to_index,           only: [:join_volunteer_info]
  before_action :set_login_account,       only: [:join_volunteer_info, :join_volunteer_accept]
  before_action :set_join_volunteer_info, only: [:join_volunteer_info, :join_volunteer_accept]

  def join_volunteer_info
  end

  def join_volunteer_accept
    @join_volunteer.create_notification_accept_registration!(@join_volunteer, @account_info)
    if @join_volunteer.accept_flag == false
      @join_volunteer.accept_flag = true
      redirect_to volunteer_accepts_join_info_path(@join_volunteer.volunteer.id) if @join_volunteer.save!
    end
  end

  def set_join_volunteer_info
    @join_volunteer = JoinVolunteer.includes(:volunteer).find_by(volunteer_id: params[:volunteer_id])
  end

  def set_login_account
    if user_signed_in?
      @account_info = current_user
      @account_type = 'User'
    elsif group_signed_in?
      @account_info = current_group
      @account_type = 'Group'
    end
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? || group_signed_in?
  end
end
