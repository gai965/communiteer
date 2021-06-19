class ChatsController < ApplicationController
  before_action :set_login_account, only: [:create]

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to root_path
    end
  end

  private 

  def chat_params
    params.require(:chat).permit(:message, :room_id).merge(speakable_id: @account.id, speakable_type: @account.type)
  end

end
