class VolunteersController < ApplicationController
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]

  def new
    redirect_to mains_sign_in_choice_path unless user_signed_in? || group_signed_in?
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    if user_signed_in?
      @volunteer.postable_id = current_user.id
      @volunteer.postable_type = 'User'
    else
      @volunteer.postable_id = current_group.id
      @volunteer.postable_type = 'Group'
    end

    set_volunteer_noimage

    if @volunteer.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    login_discrimination
    apply_verification
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

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
    set_volunteer_noimage

    if @volunteer.postable_type == 'User'
      @icon_image_path = '/assets/user_icon.png'
    elsif @volunteer.postable_type == 'Group'
      @icon_image_path = '/assets/group_icon.png'
    end
  end

  def set_volunteer_noimage
    if @volunteer.image.blank?
      @volunteer.image.attach(io: File.open($noimage_path), filename: 'noimage.png')
    end
  end

  def login_discrimination
    if user_signed_in?
      @volunteer.login_discrimination = true if 
      @volunteer.postable_id == current_user.id && @volunteer.postable_type == 'User'
    elsif group_signed_in?
      @volunteer.login_discrimination = true if 
      @volunteer.postable_id == current_group.id && @volunteer.postable_type == 'Group'
    end
  end

  def apply_verification
    join_volunteer_verification = JoinVolunteer.find_by(user_id: current_user.id, volunteer_id: @volunteer.id)
    if join_volunteer_verification.present?
      @volunteer_apply_finish_flag = true
    end
  end

  private

  def volunteer_params
    params.require(:volunteer).permit(:image, :title, :place, :details, :schedule, :start_time, :end_time, :expenses, :application_people, :conditions, :deadline)
  end
end
