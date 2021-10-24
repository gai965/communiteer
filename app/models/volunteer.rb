class Volunteer < ApplicationRecord
  belongs_to :postable, polymorphic: true
  has_one_attached :image
  has_many :join_volunteers, dependent: :destroy
  has_many :notifications,  as: :linkable, dependent: :destroy
  has_many :cheers,         as: :targetable, dependent: :destroy

  is_impressionable # gem「impressionism」で使用

  validates :details,   length: { maximum: 10_000 }
  validates :expenses,  length: { maximum: 50 }
  validates :conditions, length: { maximum: 100 }

  with_options presence: true do
    validates :title,             length: { maximum: 50 }
    validates :place,             length: { maximum: 50 }
    validates :schedule
    validates :application_people, numericality: { greater_than: 0 }
    validates :deadline
  end

  def volunteer_title
    title
  end

  # ----バリデーション-----------------------------------------------------

  # 活動日が「明日以降」でしか登録できない
  validate :schedule_after_tomorrow, if: -> { schedule.present? }
  def schedule_after_tomorrow
    errors.add(:schedule, 'は「明日以降」の日付で登録してください') if
    schedule < Date.tomorrow
  end

  # 募集締切日が「活動日前」でしか登録できない
  validate :deadline_before_schedule, if: -> { schedule.present? && deadline.present? }
  def deadline_before_schedule
    errors.add(:deadline, 'は活動日より早い日付で入力してください') if
    deadline > schedule
  end

  # 終了時間だけ入力は登録できない
  validate :end_only, if: -> { start_time.blank? && end_time.present? }
  def end_only
    errors.add(:start_time, 'を入力してください')
  end

  # 活動開始時間が終了時間より早くないと登録できない
  validate :start_before_end, if: -> { start_time.present? && end_time.present? }
  def start_before_end
    errors.add(:start_time, 'は終了時間より早い時間を入力してください') if start_time > end_time
  end

  # ----クラスメソッド-----------------------------------------------------

  # ---サーチ機能(投稿名のみ)---
  def self.search(title)
    items = Volunteer.all.order('created_at DESC')
    if title != ''
      split_keyword = title.split(/[[:blank:]]+/)
      split_keyword.each do |keyword|
        next if keyword == ''

        items = items.where('title LIKE(?)', "%#{keyword}%")
      end
    end
    items
  end

  # ---サーチ機能(詳細)---
  def self.detail(*box)
    items = Volunteer.all.order('created_at DESC')
    box.each_with_index do |value, i|
      case i
      when 0
        items = sieve1(items, value, 'title LIKE(?)')
      when 1
        items = sieve2(items, value, 'schedule >= ?')
      when 2
        items = sieve2(items, value, 'application_people >= ?')
      when 3
        items = sieve1(items, value, 'place LIKE(?)')
      when 4
        case value
        when 'recruitment'
          items = items.where(deadline_flag: false)
        when 'deadline'
          items = items.where(deadline_flag: true)
        end
      end
    end
    items
  end

  def self.sieve1(items, value, conditions)
    split_value = value.split(/[[:blank:]]+/)
    split_value.each do |keyword|
      next if keyword == ''

      items = items.where(conditions, "%#{keyword}%")
    end
    items
  end

  def self.sieve2(items, value, conditions)
    items = items.where(conditions, value) if value != ''
    items
  end

  # ---ボランティア投稿に画像がない場合「noimage」をつける---
  def volunteer_noimage(image)
    noimage_path = File.expand_path('app/assets/images/noimage.png', Rails.root)
    image.attach(io: File.open(noimage_path), filename: 'noimage.png') if image.blank?
  end

  # ---投稿者と閲覧者が同一アカウントか確認---
  def contributor_verification(volunteer, account)
    return true if volunteer.postable_id == account.id && volunteer.postable_type == account.type
  end

  # ---ボランティア投稿に申し込み済か確認---
  def application_verification(volunteer, account, approval)
    return unless approval.present?

    join_volunteer_verification = JoinVolunteer.find_by(joinable_id: account.id, joinable_type: account.type,
                                                        volunteer_id: volunteer.id)
    return true if join_volunteer_verification.present?
  end

  # ---ボランティア投稿に応援した場合の通知---
  def create_notification_cheer_registration!(volunteer, account_info)
    notification = account_info.active_notifications.new(
      post_id: volunteer.id,
      linkable: volunteer,
      receiveable_id: volunteer.postable_id,
      receiveable_type: volunteer.postable_type,
      action: 'cheer'
    )
    notification.save!
  end
end
