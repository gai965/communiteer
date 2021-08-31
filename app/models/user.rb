class User < ApplicationRecord
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

  validates_format_of :password, with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]+\z/,
                                 message: 'は大文字を含む英字と数字を入力してください'

  with_options presence: true, uniqueness: true do
    validates :name
  end

  def contributor_name
    name
  end

  def image_icon_path
    '/assets/user_icon.png'
  end

  def self.guest
    User.find_or_create_by!(email: 'user@guest.com') do |user|
      user.name = 'ゲスト'
      user.type = 'User'
      user.password = 'UserGuest01'
    end
  end
end
