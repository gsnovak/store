class Address < ApplicationRecord
  validates :zip_code, presence: true, length: { is: 5 }
  validates :street_addr, :street_addr_2, :name, :city, presence: true

  belongs_to :user
  belongs_to :state
end
