class Address < ApplicationRecord
  validates :zip_code, :state, presence: true
  belongs_to :user
end
