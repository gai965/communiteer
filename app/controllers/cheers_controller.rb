class CheersController < ApplicationController
 before_action :move_to_index, only: [:volunteer_cheer_index, :volunteer_cheer_create]
 before_action :set_info, only: [:volunteer_cheer_create, :volunteer_cheer_destroy]

 def volunteer_cheer_index
 end

 def volunteer_cheer_create
   cheer = Cheer.new(cheerable_id: @account_id, cheerable_type:@account_type, targetable_id:@target_id, targetable_type:@target_type)
   if cheer.save!
     @volunteer.create_notification_cheer_registration!(@volunteer, @account_info)
     redirect_to volunteer_path(@volunteer.id)
   end
 end

 def volunteer_cheer_destroy
  cheer = Cheer.find_by(cheerable_id: @account_id, cheerable_type: @account_type, targetable_id:params[:volunteer_id])
  if cheer.destroy
    redirect_to volunteer_path(params[:volunteer_id])
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
     @target_type = 'Volunteer'
   end
 end


end