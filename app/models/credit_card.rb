class CreditCard < ApplicationRecord
  validates :first_name, :last_name, :token, :month, :year, presence: true
  belongs_to :user
end
