class Group < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 半角英数字および大文字を含む
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]+\z/,
                      message: 'Include all uppercase and lowercase letters and numbers' }
  # 「http:」または「https:」を含む(空白も可)
  validates :url,
            format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, allow_blank: true,
                      message: 'Include "http" or "https" in the acronym' }

  with_options presence: true do
    validates :name
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'Applies to character restrictions' } # 「-」を除く10-11桁の数字
    validates :base_address
    validates :group_category, numericality: { less_than: 4, message: 'Select'}
  end

  def self.guest
    group = Group.find_or_create_by!(email: 'group@guest.com') do |group|
      group.name = 'ゲスト団体'
      group.phone_number = '0000000000'
      group.base_address = '東京都新宿区西新宿2丁目8-1'
      group.url = 'http://www.communiteer.co.jp/'
      group.group_category = '0'
      group.password = 'GroupGuest01'
    end
  end
end
