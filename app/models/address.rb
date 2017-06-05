class Address < ApplicationRecord
  validates :zip_code, presence: true
  belongs_to :user
end
