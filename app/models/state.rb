class State < ApplicationRecord
  validates :abbreviation, :name, presence: true
  has_many :address
end
