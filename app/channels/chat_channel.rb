class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chat_channel'
  end

  def unsubscribed
    
  end

  def speak(data)
    chat = Chat.create!(message: data['message'], room_id: data['room_id'], speakable_id: data['speakable_id'], speakable_type: data['speakable_type'])
    ActionCable.server.broadcast('chat_channel', { chat: render_chat(chat) })
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
