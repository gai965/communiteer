module RoomsHelper
  def unchecked_chat
    rooms_id = Room.where(selfable_id: @account.id,
                          selfable_type: @account.type).or(Room.where(partnerable_id: @account.id,
                                                                      partnerable_type: @account.type)).pluck(:id)
    check    = Chat.where(room_id: rooms_id, checked: false).where.not(speakable_id: @account.id, speakable_type: @account.type)
    return true if check.present?
  end

  def speaker_confirmation(chat)
    return true if chat.speakable_id == @account.id && chat.speakable_type == @account.type
  end

end
