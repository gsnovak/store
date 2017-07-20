class Address < ApplicationRecord
  validates :zip_code, presence: true, length: { is: 5 }

  belongs_to :user
  belongs_to :state
end
