class VolunteersController < ApplicationController
  before_action :move_to_index, only: [:new, :edit]
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]

  def new
    redirect_to mains_sign_in_choice_path unless user_signed_in? || group_signed_in?
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    @volunteer.set_volunteer_noimage(@volunteer.image)
    if user_signed_in?
      @volunteer.postable_id = current_user.id
      @volunteer.postable_type = 'User'
    else
      @volunteer.postable_id = current_group.id
      @volunteer.postable_type = 'Group'
    end
    if @volunteer.valid?
      @volunteer.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @volunteer_contributor_flag = @volunteer.contributor_verification(@volunteer.postable_id, @volunteer.postable_type,
                                                                      @account_id, @account_type)
    @volunteer_apply_finish_flag = @volunteer.application_verification(@volunteer.id, @account_id, @account_type, @approval)
    @volunteer_cheer_finish_flag = @volunteer.cheer_verification(@volunteer.id, @account_id, @account_type)
    @cheer_number = Cheer.where(targetable_id: params[:id]).count
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

  def move_to_index
    redirect_to root_path unless user_signed_in? || group_signed_in?
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
      @account_id = current_user.id
      @account_type = 'User'
      @approval = true
    elsif group_signed_in?
      @account_id = current_group.id
      @account_type = 'Group'
      @group = Group.find(current_group.id)
      @approval = true if @group.group_category == 1
    end
  end
end
