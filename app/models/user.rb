class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # 半角英数字および大文字を含む
  validates_format_of :password, with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]+\z/.freeze, message: 'Include all uppercase and lowercase letters and numbers'

  with_options presence: true, uniqueness: true do
    validates :nickname
  end

  def self.guest
    user = User.find_or_create_by!(email: 'user@guest.com') do |user|
    user.nickname = 'ゲスト'
    user.password = 'UserGuest01'
    end
  end

end