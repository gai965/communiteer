class SubmissionsController < ApplicationController
  before_action :move_to_index,     only: [:join_volunteer_index, :join_volunteer_new]
  before_action :set_login_account, only: [:join_volunteer_index, :join_volunteer_new, :join_volunteer_create]
  before_action :set_volunteer,     only: [:join_volunteer_index, :join_volunteer_new, :join_volunteer_create]

  def join_volunteer_index
    all_join_volunteer = JoinVolunteer.where(volunteer_id: params[:volunteer_id])
    @per_join_volunteer = all_join_volunteer.page(params[:page]).per(12)
    @all_join_volunteer_number = all_join_volunteer.count
  end

  def join_volunteer_new
    @join_volunteer = if params[:name].present?
                        JoinVolunteer.new(name: params[:name], phone_number: params[:phone_number])
                      else
                        JoinVolunteer.new
                      end
  end

  def join_volunteer_create
    @join_volunteer = JoinVolunteer.new(join_volunteer_params)
    set_join_volunteer_info

    if @join_volunteer.save
      @join_volunteer.create_notification_join_registration!(@join_volunteer, @account)
      @volunteer.participant_number += @join_volunteer.number
      @volunteer.save
      redirect_to volunteer_path(@volunteer.id)
    else
      render :join_volunteer_new
    end
  end
  
  private

  def join_volunteer_params
    params.require(:join_volunteer).permit(:name, :phone_number, :number, :inquiry).merge(volunteer_id: @volunteer.id)
  end

  def set_volunteer
    @volunteer = Volunteer.find(params[:volunteer_id])
  end

  def set_join_volunteer_info
    @join_volunteer.joinable_id = @account.id
    @join_volunteer.joinable_type = @account_type
  end
end
