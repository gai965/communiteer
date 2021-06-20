class ChatsController < ApplicationController
  before_action :set_login_account, only: [:create]

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to room_path(@chat.room_id, room_id:@chat.room_id)
    end
  end
  def destroy
    @chat = Chat.find(params[:id])
    if @chat.destroy!
      redirect_to room_path(@chat.room_id, room_id:@chat.room_id)
    end
  end

  private 

  def chat_params
    params.require(:chat).permit(:message, :room_id).merge(speakable_id: @account.id, speakable_type: @account.type)
  end

end
