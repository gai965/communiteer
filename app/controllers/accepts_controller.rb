class AcceptsController < ApplicationController
  before_action :set_join_volunteer_info, only: [:create]
  before_action :set_login_account,       only: [:create]

  def create
    @join_volunteer.create_notification_accept_registration!(@join_volunteer, @account)
    return unless @join_volunteer.accept_flag == false
    
    @join_volunteer.update!(accept_flag: true)
    return unless @join_volunteer.save!
    redirect_to volunteer_join_path(@join_volunteer.volunteer_id, @join_volunteer.joinable_id,
                                      type: @join_volunteer.joinable_type)
  end

  private

  def set_join_volunteer_info
    @volunteer = Volunteer.find(params[:volunteer_id])
    @join_volunteer = JoinVolunteer.find_by(volunteer_id: params[:volunteer_id], joinable_id: params[:id],
                                            joinable_type: params[:type])
  end
end
