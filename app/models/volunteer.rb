class Volunteer < ApplicationRecord
  belongs_to :postable, polymorphic: true
  has_one_attached :image

  validates :details, length: { maximum: 1000 }

  with_options presence: true do
    validates :title, length: { maximum: 100 }
    validates :place
    validates :schedule
    validates :application_people
    validates :deadline
  end
end
