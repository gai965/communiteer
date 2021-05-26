class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :linkable,    polymorphic: true
  belongs_to :sendable,    polymorphic: true
  belongs_to :receiveable, polymorphic: true
end
