class PagesController < ApplicationController
  before_action :set_login_account, only: [:show]
  before_action :set_profile_edit_path, only: [:show]
  before_action :set_page_info,         only: [:show]

  def show
    @room_id = Room.where(selfable_id:@account.id, selfable_type:@account.type).or(Room.where(partnerable_id:@account.id, partnerable_type:@account.type)).pluck(:id)
  end

  private
  
  def set_page_info
    if params[:type] == 'User'
      @account_page_info = User.find(params[:id])
      @icon_image_path = '/assets/user_icon.png'
    elsif params[:type] == 'Group'
      @account_page_info = Group.find(params[:id])
      @icon_image_path = '/assets/group_icon.png'
    end
    @account_page_info_type = params[:type]
    @post_volunteer = Volunteer.where(postable_id: @account_page_info.id, postable_type: @account_page_info_type)
    @join_volunteer = JoinVolunteer.where(joinable_id: @account_page_info.id, joinable_type: @account_page_info_type)
    post_volunteer_number = @post_volunteer.count
    join_volunteer_number = @join_volunteer.count
    @all_post_number = post_volunteer_number
    @all_join_number = join_volunteer_number
    @all_cheer_number = Cheer.where(cheerable_id: @account_page_info.id, cheerable_type: @account_page_info_type).count
  end

  def set_profile_edit_path
    if user_signed_in?
      @edit_path = edit_user_registration_path
    elsif group_signed_in?
      @edit_path = edit_group_registration_path
    end
  end
end
