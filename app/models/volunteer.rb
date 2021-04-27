class Volunteer < ApplicationRecord
  belongs_to :postable, polymorphic: true
  has_one_attached :image
  has_many :join_volunteers, dependent: :destroy

  is_impressionable # gem「impressionism」で使用 

  validates :details,   length: { maximum: 10000 }
  validates :expenses,  length: { maximum: 50 }
  validates :conditions,length: { maximum: 100 }

  with_options presence: true do
    validates :title,             length: { maximum: 50 }
    validates :place,             length: { maximum: 50 }
    validates :schedule
    validates :application_people,numericality: { greater_than: 0}
    validates :deadline
  end

  # 活動日が「明日以降」でしか登録できないバリデーション
  validate :schedule_after_tomorrow, if: -> { schedule.present? }
  def schedule_after_tomorrow
    errors.add(:schedule, 'select a date after tomorrow') if
    schedule < Date.tomorrow
  end

  # 募集締切日が「活動日前」でしか登録できないバリデーション
  validate :deadline_before_schedule, if: -> { schedule.present? && deadline.present? }
  def deadline_before_schedule
    errors.add(:deadline, 'select a date after activity day') if
    self.deadline > self.schedule
  end

  # 終了時間だけ入力は登録できないバリデーション
  validate :end_only, if: -> { start_time.blank? && end_time.present? }
  def end_only
    errors.add(:start_time, 'is also required') 
  end

  # 活動開始時間が終了時間より早くないと登録できないバリデーション
  validate :start_before_end, if: -> { start_time.present? && end_time.present? }
  def start_before_end
    errors.add(:start_time, 'enter a time earlier than the end time') if
    self.start_time > self.end_time
  end

  # ----インスタンスメソッド-----------------------------------------------------
   # ---ボランティア投稿に画像がない場合「noimage」をつける---------------------
  def set_volunteer_noimage(image)
    if image.blank?
      image.attach(io: File.open($noimage_path), filename: 'noimage.png')
    end
  end
   # ---投稿者と閲覧者が同一アカウントか確認-----------------------------------
  def contributor_verification(postable_id, postable_type, account_id, account_type)
    return true if postable_id == account_id && postable_type == account_type 
  end
  
   # ---ボランティア投稿に申し込み済か確認-------------------------------------
  def application_verification(volunteer_id, account_id, account_type, approval)
    if approval.present?
      join_volunteer_verification = JoinVolunteer.find_by(joinable_id: account_id, joinable_type: account_type, volunteer_id: volunteer_id)
      return true if join_volunteer_verification.present?
    end
  end
 
end
