class JoinVolunteer < ApplicationRecord
  belongs_to :joinable, polymorphic: true
  belongs_to :volunteer
  has_many   :notifications, as: :linkable, dependent: :destroy

  validates :phone_number, format: { with: /\A\d{10,11}\z/, allow_blank: true, message: 'は10桁または11桁の半角数字で入力してください' }
  validates :inquiry, length: { maximum: 500 }

  with_options presence: true do
    validates :name, length: { maximum: 30 }
    validates :number, numericality: { greater_than: 0 }
  end

  # 参加承諾の有無を確認
  def already_accept?
    return false if accept_flag == false

    true
  end

  # 登録時の相手側通知
  def create_notification_join_registration!(join_volunteer, account_info)
    notification = account_info.active_notifications.new(
      post_id: join_volunteer.volunteer.id,
      linkable: join_volunteer,
      receiveable_id: volunteer.postable_id,
      receiveable_type: volunteer.postable_type,
      action: 'join_volunteer'
    )
    notification.save!
  end

  # 承諾時の相手側通知
  def create_notification_accept_registration!(join_volunteer, account_info)
    notification = account_info.active_notifications.new(
      post_id: join_volunteer.volunteer.id,
      linkable: join_volunteer,
      receiveable_id: join_volunteer.joinable_id,
      receiveable_type: join_volunteer.joinable_type,
      action: 'accept_volunteer'
    )
    notification.save!
  end
end
