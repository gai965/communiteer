class JoinVolunteersController < ApplicationController
  before_action :move_to_top,       only: [:index, :new]
  before_action :set_login_account, only: [:index, :new, :create]
  before_action :set_volunteer,     only: [:index, :new, :create]

  def index
    all_join_volunteer = JoinVolunteer.where(volunteer_id: params[:volunteer_id])
    @per_join_volunteer = all_join_volunteer.page(params[:page]).per(6)
    @all_join_volunteer_number = all_join_volunteer.count
  end

  def new
    @join_volunteer = if params[:name].present?
                        JoinVolunteer.new(name: params[:name], phone_number: params[:phone_number])
                      else
                        JoinVolunteer.new
                      end
  end

  def create
    @join_volunteer = JoinVolunteer.new(join_volunteer_params)
    set_join_volunteer_info

    if @join_volunteer.save
      @join_volunteer.create_notification_join_registration!(@join_volunteer, @account)
      @volunteer.participant_number += @join_volunteer.number
      @volunteer.save
      redirect_to volunteer_path(@volunteer.id)
    else
      render :new
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
    @join_volunteer.joinable_type =  @account.type
  end
end