class CheersController < ApplicationController
  before_action :move_to_index, only: [:volunteer_cheer_index, :volunteer_cheer_create]

  def volunteer_cheer_index
  end

  def volunteer_cheer_create
    set_info
    cheer = Cheer.new(cheerable_id: @account_id, cheerable_type:@account_type, targetable_id:@target_id, targetable_type:@target_type)
    if cheer.save!
      
      redirect_to root_path
    end
  end
  
  def move_to_index
    redirect_to root_path unless user_signed_in? || group_signed_in?
  end
  
  private

  def set_info
    if user_signed_in?
      @account_id   = current_user.id
      @account_type = 'User'
      @account_info = current_user
    else
      @account_id   = current_group.id
      @account_type = 'Group'
      @account_info = current_group
    end

    if params[:action] == 'volunteer_cheer_create'
      @volunteer   = Volunteer.find(params[:volunteer_id]) 
      @target_id   = @volunteer.id
      # @target_id   =  params[:volunteer_id]
      @target_type = 'Volunteer'
    end
  end


end