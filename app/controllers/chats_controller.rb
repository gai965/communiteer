class ChatsController < ApplicationController
  before_action :set_login_account, only: [:create, :destroy]

  def create
    return unless params[:message].present?

    chat = Chat.create(message: params[:message], room_id: params[:room_id], speakable_id: @account.id,
                       speakable_type: @account.type)
    render json: { post: chat }
  end

  def destroy
    chat = Chat.find(params[:id])
    chat.destroy
    @all_chats = Chat.where(room_id: chat.room_id).includes(:room)
  end
end
