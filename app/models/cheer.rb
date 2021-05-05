class Cheer < ApplicationRecord
  belongs_to :cheerable,  polymorphic: true
  belongs_to :targetable, polymorphic: true
  # validates_uniqueness_of :targetable, scope: :cheerable
end