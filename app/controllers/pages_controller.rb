class PagesController < ApplicationController
  before_action :set_profile_edit_path, only: [:show]

  def show
    if params[:type] == 'User'
      @page_info = User.find(params[:id])
    elsif params[:type] == 'Group'
      @page_info = Group.find(params[:id])
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
