class RoomsController < ApplicationController
  before_action :set_login_account, only: [:index,:show, :create]

  def index
    @chats = []
    rooms_id = Room.where(selfable_id:@account.id, selfable_type:@account.type).or(Room.where(partnerable_id:@account.id, partnerable_type:@account.type)).pluck(:id)
    rooms_id.each do |id|
      chat = Chat.where(room_id: id).where.not(speakable_id:@account.id, speakable_type:@account.type).order(updated_at: :desc).limit(1)
      @chats.push(chat) if chat.present?
    end
  end

  def show
    @room = Room.find_by(id: params[:room_id])
    @all_chats     = Chat.where(room_id: params[:room_id]).includes(:room)
    @my_chats      = Chat.where(speakable_id:@account.id, speakable_type:@account.type, room_id: params[:room_id]).includes(:room)
    @partner_chats = Chat.where(room_id: params[:room_id]).where.not(speakable_id:@account.id, speakable_type:@account.type).includes(:room)
    @partner_chats.where(checked: false).each do |partner_chat|
      partner_chat.update(checked: true)
    end
    @chat = Chat.new
  end

  def create
    @room = Room.where(selfable_id:@account.id, selfable_type:@account.type , partnerable_id: params[:partner_id], partnerable_type:params[:partner_type]).or(Room.where(selfable_id: params[:partner_id], selfable_type:params[:partner_type], partnerable_id:@account.id, partnerable_type:@account.type)).first
    if @room.blank?
      @room = Room.create!(selfable_id:@account.id, selfable_type:@account.type , partnerable_id: params[:partner_id], partnerable_type:params[:partner_type])
    end
    redirect_to room_path(@account.id, room_id:@room.id)
  end
end
