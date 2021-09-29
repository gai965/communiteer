class ChatsController < ApplicationController
  before_action :set_login_account, only: [:index, :destroy]
  before_action :move_to_top,       only: [:index]
  before_action :set_header_info,   only: [:index]

  def index
    @room = Room.find_by(id: params[:room_id])
    if @room.selfable_id == @account.id && @room.selfable_type == @account.type
      @partner_name = @room.partnerable.name
    elsif @room.partnerable_id == @account.id && @room.partnerable_type == @account.type
      @partner_name = @room.selfable.name
    end
    @all_chats     = Chat.where(room_id: params[:room_id]).includes(:room)
    partner_chats = Chat.where(room_id: params[:room_id]).where.not(speakable_id: @account.id,
                                                                     speakable_type: @account.type).includes(:room)
    partner_chats.where(checked: false).each do |partner_chat|
      partner_chat.update(checked: true)
    end
  end

  def destroy
    chat = Chat.find(params[:id])
    ActionCable.server.broadcast('chat_channel', { delete_id: chat.id})
  end
end
