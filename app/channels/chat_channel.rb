class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chat_channel'
    stream_for current_account
  end

  def unsubscribed
  end

  def speak(data)
    chat = Chat.create!(message: data['message'], room_id: data['room_id'], speakable_id: data['speakable_id'], speakable_type: data['speakable_type'])
    partner_account(data['partner_id'], data['partner_type'])
    ChatChannel.broadcast_to(current_account,
      chat: chat,
      chat_time: chat.updated_at.strftime('%H:%M'),
      isCurrent_user: true
    )
    ChatChannel.broadcast_to(@partner_account,
      chat: chat,
      chat_time: chat.updated_at.strftime('%H:%M'),
      image_path:chat.speakable.image_icon_path,
      isCurrent_user: false
    )
  end

  def delete(data)
    chat = Chat.find(data['id'])
    partner_account(data['partner_id'], data['partner_type'])
    ChatChannel.broadcast_to(current_account,
      delete_chat: chat.id,
      isCurrent_user: true
    )
    ChatChannel.broadcast_to(@partner_account,
      delete_chat: chat.id,
      isCurrent_user: false
    )
    # ActionCable.server.broadcast('chat_channel', { delete_chat: chat.id })
    chat.destroy!
  end
  
  private
  
  def partner_account(partner_id, partner_type)
    case partner_type
    when 'User'
      @partner_account = User.find(partner_id)
    when 'Group'
      @partner_account = Group.find(partner_id)
    end
  end
end
