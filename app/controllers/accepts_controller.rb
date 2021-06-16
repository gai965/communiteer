class AcceptsController < ApplicationController
  before_action :move_to_top,             only: [:show]
  before_action :set_login_account,       only: [:show, :create]
  before_action :set_join_volunteer_info, only: [:show, :create]

  def show
  end

  def create
    @join_volunteer.create_notification_accept_registration!(@join_volunteer, @account)
    if @join_volunteer.accept_flag == false
      @join_volunteer.accept_flag = true
      redirect_to volunteer_accept_path(@join_volunteer.volunteer_id, @join_volunteer.joinable_id, type: @join_volunteer.joinable_type) if @join_volunteer.save!
    end
  end

  def set_join_volunteer_info
    @volunteer = Volunteer.find(params[:volunteer_id])
    @join_volunteer = JoinVolunteer.find_by(volunteer_id: params[:volunteer_id], joinable_id: params[:id], joinable_type: params[:type])
  end
end
