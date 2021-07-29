class RoomsController < ApplicationController
  before_action :set_login_account, only: [:index, :show, :create]
  before_action :set_header_info,   only: [:index,:show]

  def index
    @rooms = Room.where(selfable_id: @account.id,
                        selfable_type: @account.type).or(Room.where(partnerable_id: @account.id,
                                                                    partnerable_type: @account.type)).includes(:chat)
  end

  def show
    @room = Room.find_by(id: params[:room_id])
    if @room.selfable_id == @account.id && @room.selfable_type == @account.type
      @partner_name = @room.partnerable.name
    elsif @room.partnerable_id == @account.id && @room.partnerable_type == @account.type
      @partner_name = @room.selfable.name
    end
    @all_chats     = Chat.where(room_id: params[:room_id]).includes(:room)
    @partner_chats = Chat.where(room_id: params[:room_id]).where.not(speakable_id: @account.id,
                                                                     speakable_type: @account.type).includes(:room)
    @partner_chats.where(checked: false).each do |partner_chat|
      partner_chat.update(checked: true)
    end
    @chat = Chat.new
  end

  def create
    @room = Room.where(selfable_id: [@account.id, params[:partner_id]], selfable_type: [@account.type, params[:partner_type]],
                       partnerable_id: [@account.id, params[:partner_id]], partnerable_type: [@account.type, params[:partner_type]]).first
    if @room.blank?
      @room = Room.create!(selfable_id: @account.id, selfable_type: @account.type, partnerable_id: params[:partner_id],
                           partnerable_type: params[:partner_type])
    end
    redirect_to room_path(@account.id, room_id: @room.id, partner_id: params[:partner_id], partner_type: params[:partner_type])
  end
end
