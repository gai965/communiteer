class AcceptsController < ApplicationController
  before_action :move_to_top,             only: [:show]
  before_action :set_login_account,       only: [:show, :create]
  before_action :set_join_volunteer_info, only: [:show, :create]

  def show
    @room_id = Room.where(selfable_id: @account.id,
                          selfable_type: @account.type).or(Room.where(partnerable_id: @account.id,
                                                                      partnerable_type: @account.type)).pluck(:id)
  end

  def create
    @join_volunteer.create_notification_accept_registration!(@join_volunteer, @account)
    if @join_volunteer.accept_flag == false
      @join_volunteer.accept_flag = true
      if @join_volunteer.save!
        redirect_to volunteer_accept_path(@join_volunteer.volunteer_id, @join_volunteer.joinable_id,
                                          type: @join_volunteer.joinable_type)
      end
    end
  end

  private

  def set_join_volunteer_info
    @volunteer = Volunteer.find(params[:volunteer_id])
    @join_volunteer = JoinVolunteer.find_by(volunteer_id: params[:volunteer_id], joinable_id: params[:id],
                                            joinable_type: params[:type])
  end
end
