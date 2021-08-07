class CheersController < ApplicationController
  before_action :move_to_top,       only: [:create]
  before_action :set_login_account, only: [:index, :create, :destroy]
  before_action :set_volunteer,     only: [:index, :create]

  def index
    @cheers_volunteer = Cheer.where(targetable_id: params[:volunteer_id]).order('created_at DESC').page(params[:page]).per(6)
  end

  def create
    cheer = Cheer.new(cheerable_id: @account.id, cheerable_type:  @account.type, targetable_id: @volunteer.id,
                      targetable_type: @target_type)
    return unless cheer.save!

    @volunteer.create_notification_cheer_registration!(@volunteer, @account)
    redirect_to volunteer_path(@volunteer.id)
  end

  def destroy
    cheer = Cheer.find_by(cheerable_id: @account.id, cheerable_type: @account.type, targetable_id: params[:volunteer_id])
    redirect_to volunteer_path(params[:volunteer_id]) if cheer.destroy
  end

  private

  def set_volunteer
    @volunteer   = Volunteer.find(params[:volunteer_id])
    @target_type = 'Volunteer'
  end
end
