class PagesController < ApplicationController
  before_action :set_profile_edit_path, only: [:show]

  def show
    if params[:type] == 'User'
      @account_page_info = User.find(params[:id])
      @account_page_info_type = params[:type]
      @icon_image_path = '/assets/user_icon.png'
    elsif params[:type] == 'Group'
      @account_page_info_type = params[:type]
      @account_page_info = Group.find(params[:id])
      @icon_image_path = '/assets/group_icon.png'
    end
  end

  def set_profile_edit_path
    set_login_account
    if user_signed_in?
      @edit_path = edit_user_registration_path
    elsif group_signed_in?
      @edit_path = edit_group_registration_path
    end
  end
end
