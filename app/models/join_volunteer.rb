class JoinVolunteer < ApplicationRecord
  belongs_to :joinable, polymorphic: true
  belongs_to :volunteer
  has_many   :notifications, dependent: :destroy

  validates :phone_number,format: { with: /\A\d{10,11}\z/, allow_blank: true, message: 'Applies to character restrictions' }
  validates :inquiry,     length: { maximum: 100 }
  
  with_options presence: true do
    validates :name,  length: { maximum: 30 }
    validates :number,numericality: { greater_than: 0, message: 'of participants must be greater than 0' }
  end

  # ---インスタンスメソッド---------------------------------
   #----登録時の通知-----------------------------------
    def create_notification_registration!(join_volunteer, volunteer, account_info)
      notification = account_info.active_notifications.new(
        item_id:          volunteer.id,
        join_volunteer:   join_volunteer,
        sendable_id:      volunteer.postable_id, 
        sendable_type:    volunteer.postable_type,
        receiveable_id:   join_volunteer.joinable_id,
        receiveable_type: join_volunteer.joinable_type,
        action:           'join_volunteer'
      )
      if notification.sendable_id == notification.sendable_id
        notification.checked = true
      end
      notification.save!
   end
end