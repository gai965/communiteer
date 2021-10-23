class VolunteersController < ApplicationController
  before_action :set_login_account, expect: [:new]
  before_action :move_to_login,     only:   [:new, :edit]
  before_action :set_header_info,   only:   [:index, :show]
  before_action :set_volunteer,     only:   [:show, :edit, :update, :destroy, :close]

  def index
    @all_volunteer = Volunteer.all.order('created_at DESC')
  end

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    @volunteer.volunteer_noimage(@volunteer.image)
    @volunteer.postable_id = @account.id
    @volunteer.postable_type = @account.type

    if @volunteer.valid?
      @volunteer.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @cheer = Cheer.where(targetable_id: params[:id])
    @cheer_number = @cheer.count
    impressionist(@volunteer, nil, unique: [:session_hash])
  end

  def edit
  end

  def update
    if @volunteer.update(volunteer_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @volunteer.destroy
    redirect_to root_path
  end

  def close
    @volunteer.update(deadline_flag: true)
  end

  def search
    @per_volunteer = Volunteer.search(params[:keyword])
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:image, :title, :place, :details, :schedule, :start_time, :end_time, :expenses,
                                      :application_people, :conditions, :deadline, :kind)
  end

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
    @volunteer.volunteer_noimage(@volunteer.image)

    if user_signed_in?
      @approval = true
    elsif group_signed_in?
      @group = Group.find(@account.id)
      @approval = true if @group.group_category == 1
    end
  end
end
