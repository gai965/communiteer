class CheersController < ApplicationController
  before_action :move_to_index,     only: [:volunteer_cheer_index, :volunteer_cheer_create]
  before_action :set_cheer_info,    only: [:volunteer_cheer_create]
  before_action :set_login_account, only: [:volunteer_cheer_index, :volunteer_cheer_create, :volunteer_cheer_destroy]
 
  def volunteer_cheer_index
    @cheers_volunteer = Cheer.where(targetable_id: params[:volunteer_id]).order('created_at DESC').page(params[:page]).per(6)
    
  end
 
  def volunteer_cheer_create
    cheer = Cheer.new(cheerable_id: @account.id, cheerable_type:@account_type, targetable_id:@target_id, targetable_type:@target_type)
    if cheer.save!
      @volunteer.create_notification_cheer_registration!(@volunteer, @account)
      redirect_to volunteer_path(@volunteer.id)
    end
  end
 
  def volunteer_cheer_destroy
   cheer = Cheer.find_by(cheerable_id: @account.id, cheerable_type: @account_type, targetable_id:params[:volunteer_id])
   if cheer.destroy
     redirect_to volunteer_path(params[:volunteer_id])
   end
  end

  private

  def set_cheer_info
    if params[:action] == 'volunteer_cheer_create'
      @volunteer   = Volunteer.find(params[:volunteer_id]) 
      @target_id   = @volunteer.id
      @target_type = 'Volunteer'
    end
  end
end