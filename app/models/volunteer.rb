class Volunteer < ApplicationRecord
  belongs_to :postable, polymorphic: true
  has_one_attached :image

  validates :details, length: { maximum: 1000 }

  with_options presence: true do
    validates :title,             length: { maximum: 100 }
    validates :place
    validates :schedule
    validates :application_people,numericality: { greater_than: 0}
    validates :deadline
  end

  # 活動日が「明日以降」でしか登録できないバリデーション
  validate :schedule_after_tomorrow
  def schedule_after_tomorrow
    errors.add(:schedule, 'は明日以降のものを選択してください') if
    schedule < Date.tomorrow
  end

  # 募集締切日が「活動日前」でしか登録できないバリデーション
  validate :deadline_before_schedule
  def deadline_before_schedule
    errors.add(:deadline, 'は活動日以前のものを選択してください') if
    self.deadline > self.schedule
  end
end
