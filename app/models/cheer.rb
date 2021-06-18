class Cheer < ApplicationRecord
  belongs_to :cheerable,  polymorphic: true
  belongs_to :targetable, polymorphic: true
end
