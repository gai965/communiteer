class VolunteersController < ApplicationController
  before_action :move_to_login,     only:  [:new, :edit]
  before_action :set_login_account, expect:[:new]
  before_action :set_volunteer,     only:  [:show, :edit, :update, :destroy]

  def index
    all_volunteer = Volunteer.all.order('created_at DESC')
    @per_volunteer = all_volunteer.page(params[:page]).per(12)
    @all_volunteer_number = all_volunteer.count
  end

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    @volunteer.set_volunteer_noimage(@volunteer.image)
    @volunteer.postable_id = @account.id
    @volunteer.postable_type =  @account.type

    if @volunteer.valid?
      @volunteer.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @cheer_number = Cheer.where(targetable_id: params[:id]).count
    if @account.present?
      @volunteer_contributor_flag = @volunteer.contributor_verification(@volunteer, @account.id,  @account.type)
      @volunteer_apply_finish_flag = @volunteer.application_verification(@volunteer, @account.id,  @account.type, @approval)
      @volunteer_cheer_finish_flag = @volunteer.cheer_verification(@volunteer, @account.id,  @account.type)
    end
    impressionist(@volunteer, nil, unique: [:session_hash])
  end

  def edit
  end

  def update
    @volunteer.update(volunteer_params)
    if @volunteer.save
      redirect_to action: :show
    else
      redirect_to action: :edit
    end
  end

  def destroy
    @volunteer.destroy
    redirect_to root_path
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:image, :title, :place, :details, :schedule, :start_time, :end_time, :expenses,
                                      :application_people, :conditions, :deadline)
  end

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
    @volunteer.set_volunteer_noimage(@volunteer.image)

    if user_signed_in?
      @approval = true
    elsif group_signed_in?
      @group = Group.find(@account.id)
      @approval = true if @group.group_category == 1
    end
  end
end
