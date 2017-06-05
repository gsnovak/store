class CreditCard < ApplicationRecord
  validates :first_name, :last_name, :card_number, :expiration_date, presence: true 
  belongs_to :user
end
