class Chat < ApplicationRecord
  belongs_to :speakable, polymorphic: true
  belongs_to :room
end
