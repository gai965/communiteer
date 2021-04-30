class JoinVolunteer < ApplicationRecord
  belongs_to :joinable, polymorphic: true
  belongs_to :volunteer
  has_many   :notifications, dependent: :destroy

  validates :phone_number, format: { with: /\A\d{10,11}\z/, allow_blank: true, message: 'Applies to character restrictions' }
  validates :inquiry, length: { maximum: 100 }

  with_options presence: true do
    validates :name, length: { maximum: 30 }
    validates :number, numericality: { greater_than: 0, message: 'of participants must be greater than 0' }
  end

  # ---インスタンスメソッド---------------------------------
  #----登録時の通知-----------------------------------
  def create_notification_join_registration!(join_volunteer, volunteer, account_info)
    notification = account_info.active_notifications.new(
      item_id: volunteer.id,
      join_volunteer: join_volunteer,
      receiveable_id: volunteer.postable_id,
      receiveable_type: volunteer.postable_type,
      action: 'join_volunteer'
    )
    notification.save!
  end

  #----承諾時の通知-----------------------------------
  def create_notification_accept_registration!(join_volunteer, volunteer, account_info)
    notification = account_info.active_notifications.new(
      item_id: volunteer.id,
      join_volunteer: join_volunteer,
      receiveable_id: join_volunteer.joinable_id,
      receiveable_type: join_volunteer.joinable_type,
      action: 'accept_volunteer'
    )
    notification.save!
  end
end
