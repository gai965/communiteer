class JoinVolunteer < ApplicationRecord
  class JoinVolunteer < ApplicationRecord
    belongs_to :joinable, polymorphic: true
    belongs_to :volunteer
  
    with_options presence: true do
      validates :name
      validates :number
    end
  
  end
  
end
