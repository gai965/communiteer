class JoinVolunteer < ApplicationRecord
  belongs_to :joinable, polymorphic: true
  belongs_to :volunteer

  validates :phone_number,format: { with: /\A\d{10,11}\z/, allow_blank: true, message: 'Applies to character restrictions' }
  validates :inquiry,     length: { maximum: 100 }
  
  with_options presence: true do
    validates :name,  length: { maximum: 30 }
    validates :number,numericality: { greater_than: 0, message: 'of participants must be greater than 0' }
  end
end
