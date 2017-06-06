class CreditCard < ApplicationRecord
  validates :first_name, :last_name, :token, :expiration_date, presence: true
  belongs_to :user
end
