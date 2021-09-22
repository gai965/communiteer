class PagesController < ApplicationController
  protect_from_forgery
  
  before_action :set_login_account,     only: [:show]
  before_action :set_header_info,       only: [:show]
  before_action :set_profile_edit_path, only: [:show]
  before_action :set_page_account,      only: [:show]

  def show
    @post_volunteer  = Volunteer.where(postable_id: @account_page_info.id, postable_type: @account_page_info.type).page(params[:page]).per(6)
    @post_place      = nil
    @post_event      = nil
    @all_post        = @post_volunteer
    @all_post_number = @post_volunteer.count

    @join_volunteer  = Volunteer.joins(:join_volunteers).where(join_volunteers: { joinable_id: @account_page_info.id, joinable_type: @account_page_info.type}).page(params[:page]).per(6)
    @join_place      = nil
    @join_event      = nil
    @all_join        = @join_volunteer
    @all_join_number = @join_volunteer.count
    
    @cheer_volunteer  = Volunteer.joins(:cheers).where(cheers: { cheerable_id: @account_page_info.id, cheerable_type: @account_page_info.type}).page(params[:page]).per(6)
    @cheer_place      = nil
    @cheer_event      = nil  
    @all_cheer        = @cheer_volunteer
    @all_cheer_number = @all_cheer.count
    
    return unless @account.present?
    @room_id = Room.where(selfable_id: @account.id,
                          selfable_type: @account.type).or(Room.where(partnerable_id: @account.id,
                                                                      partnerable_type: @account.type)).pluck(:id)
  end

  private

  def set_page_account
    case params[:type]
    when 'User'
      @account_page_info = User.find(params[:id])
      @account_icon_image = 'user_icon.png'
    when 'Group'
      @account_page_info = Group.find(params[:id])
      @account_icon_image = 'group_icon.png'
    end
  end

  def set_profile_edit_path
    if user_signed_in?
      @edit_path = edit_user_registration_path
    elsif group_signed_in?
      @edit_path = edit_group_registration_path
    end
  end
end
