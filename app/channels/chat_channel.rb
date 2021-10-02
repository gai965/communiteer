class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chat_channel'
    stream_for current_account
  end

  def unsubscribed
  end

  def speak(data)
    chat = Chat.create!(message: data['message'], room_id: data['room_id'], speakable_id: data['speakable_id'], speakable_type: data['speakable_type'])
    case data['partner_type']
    when 'User'
      partner_account = User.find(data['partner_id'])
    when 'Group'
      partner_account = Group.find(data['partner_id'])
    end
    
    ChatChannel.broadcast_to(current_account,
        chat: chat,
        chat_time: chat.updated_at.strftime('%H:%M'),
        isCurrent_user: true
    )
    ChatChannel.broadcast_to(partner_account,
        chat: chat,
        chat_time: chat.updated_at.strftime('%H:%M'),
        isCurrent_user: false
    )
  end

  def delete(data)
    chat = Chat.find(data['id'])
    ActionCable.server.broadcast('chat_channel', { delete_chat: chat.id })
    chat.destroy!
  end

end
