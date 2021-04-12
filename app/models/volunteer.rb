class Volunteer < ApplicationRecord
  belongs_to :postable, polymorphic: true
  has_one_attached :image

  validates :details,   length: { maximum: 1000 }
  validates :expenses,  length: { maximum: 100 }
  validates :conditions, length: { maximum: 100 }

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :place
    validates :schedule
    validates :application_people, numericality: { greater_than: 0 }
    validates :deadline
  end

  # 活動日が「明日以降」でしか登録できないバリデーション
  validate :schedule_after_tomorrow, unless: -> { schedule.blank? }
  def schedule_after_tomorrow
    errors.add(:schedule, 'select a date after tomorrow') if
    schedule < Date.tomorrow
  end

  # 募集締切日が「活動日前」でしか登録できないバリデーション
  validate :deadline_before_schedule, unless: -> { schedule.blank? || deadline.blank? }
  def deadline_before_schedule
    errors.add(:deadline, 'select a date after activity day') if
    deadline > schedule
  end

  validate :start_before_end, unless: -> { start_time.blank? }
  def start_before_end
    errors.add(:start_time, 'enter a time earlier than the end time') if
    start_time > end_time
  end
end
