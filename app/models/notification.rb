class Notification < ApplicationRecord

  default_scope -> { order(created_at: :desc) }
  belongs_to :join_volunteer
  belongs_to :sendable,    polymorphic: true
  belongs_to :receiveable, polymorphic: true

end