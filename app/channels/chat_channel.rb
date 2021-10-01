class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chat_channel'
    stream_for current_account
  end

  def unsubscribed
  end

  def speak(data)
    chat = Chat.create!(message: data['message'], room_id: data['room_id'], speakable_id: data['speakable_id'], speakable_type: data['speakable_type'])
    ChatChannel.broadcast_to(current_account,
        chat: chat,
        chat_time: chat.updated_at.strftime('%H:%M'),
        isCurrent_user: true
    )
    ChatChannel.broadcast_to(
        chat: chat,
        chat_time: chat.updated_at.strftime('%H:%M'),
        isCurrent_user: true
      )
    # ActionCable.server.broadcast('chat_channel', { chat: render_chat(chat) })
  end

  def delete(data)
    chat = Chat.find(data['id'])
    ActionCable.server.broadcast('chat_channel', { delete_chat: chat.id })
    chat.destroy!
  end

  private
  
  def render_chat(chat)
    ApplicationController.render(
      partial: 'chats/my_chat',
      locals: { chat: chat }
    )
  end
end
