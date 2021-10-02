class RoomsController < ApplicationController
  before_action :set_login_account, only: [:index, :create]
  before_action :set_header_info,   only: [:index]

  def index
    @rooms = Room.where(selfable_id: @account.id,
                        selfable_type: @account.type).or(Room.where(partnerable_id: @account.id,
                                                                    partnerable_type: @account.type)).includes(:chat)
  end

  def create
    @room = (Room.where(selfable_id:@account.id, selfable_type: @account.type, partnerable_id: params[:partner_id], partnerable_type: params[:partner_type]).or(Room.where(selfable_id:params[:partner_id], selfable_type: params[:partner_type], partnerable_id: @account.id, partnerable_type: @account.type))).first
    if @room.blank?
      @room = Room.create!(selfable_id: @account.id, selfable_type: @account.type, partnerable_id: params[:partner_id],partnerable_type: params[:partner_type])
    end
    redirect_to  room_chats_path(@room.id)
  end
end
