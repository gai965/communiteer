class Room < ApplicationRecord
  belongs_to :selfable,    polymorphic: true
  belongs_to :partnerable, polymorphic: true
  has_many   :chat,        dependent: :destroy
end
