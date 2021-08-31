class Group < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :volunteers,      as: :postable, dependent: :destroy
  has_many :join_volunteers, as: :joinable
  has_many :cheers,          as: :cheerable
  has_many :rooms,           as: :selfable
  has_many :rooms,           as: :pertnerable
  has_many :chats,           as: :speakable
  has_many :active_notifications, class_name: 'Notification', as: :sendable, dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', as: :receiveable, dependent: :destroy

  # 半角英数字および大文字を含む
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]+\z/,
                      message: 'は大文字を含む英字と数字を入力してください' }
  # 「http:」または「https:」を含む(空白も可)
  validates :url,
            format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, allow_blank: true,
                      message: 'の頭字語に「http」または「https」を含めてください' }

  validates :group_category, presence: { message: 'を選択してください' }

  with_options presence: true do
    validates :name
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: '文字制限に適用されます' } # 「-」を除く10-11桁の数字
    validates :base_address
  end

  def contributor_name
    name
  end

  def image_icon_path
    '/assets/group_icon.png'
  end

  def self.guest
    Group.find_or_create_by!(email: 'group@guest.com') do |group|
      group.name = 'ゲスト団体'
      group.phone_number = '0000000000'
      group.base_address = '東京都新宿区西新宿2丁目8-1'
      group.url = 'http://www.communiteer.co.jp/'
      group.group_category = 0
      group.type = 'Group'
      group.password = 'GroupGuest01'
    end
  end
end
