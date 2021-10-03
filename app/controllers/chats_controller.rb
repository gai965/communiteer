class ChatsController < ApplicationController
  before_action :set_login_account, only: [:index, :destroy]
  before_action :move_to_top,       only: [:index]
  before_action :cookies_account,   only: [:index]
  before_action :set_header_info,   only: [:index]

  def index
    @room = Room.find_by(id: params[:room_id])
    if @room.selfable_id == @account.id && @room.selfable_type == @account.type
      partner_info(@room.partnerable)
    elsif @room.partnerable_id == @account.id && @room.partnerable_type == @account.type
      partner_info(@room.selfable)
    end
    @all_chats    = Chat.where(room_id: params[:room_id]).includes(:room)
    partner_chats = Chat.where(room_id: params[:room_id]).where.not(speakable_id: @account.id,
                                                                     speakable_type: @account.type).includes(:room)
    partner_chats.where(checked: false).each do |partner_chat|
      partner_chat.update(checked: true)
    end
  end

  def destroy
    chat = Chat.find(params[:id])
    if chat.room.selfable_id == @account.id && chat.room.selfable_type == @account.type
      partner_info(chat.room.partnerable)
    elsif chat.room.partnerable_id == @account.id && chat.room.partnerable_type == @account.type
      partner_info(chat.room.selfable)
    end
    ActionCable.server.broadcast('chat_channel', { delete_id: chat.id, partner_id: @partner_id, partner_type: @partner_type})
  end

  private 

  def partner_info(partner)
    @partner_name = partner.name
    @partner_id   = partner.id
    @partner_type = partner.type
  end

end
