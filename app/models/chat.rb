class Chat < ApplicationRecord
  belongs_to :speakable, polymorphic: true
  belongs_to :room

  def template
    ApplicationController.renderer.render partial: 'chats/my_chat', locals: { chat: self }
  end
end
