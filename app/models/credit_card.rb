class CreditCard < ApplicationRecord

  attr_accessor :number, :cvc

  validates :first_name, :last_name, :token, :month, :year, presence: true
  belongs_to :user

  # before_create read number and set last 4 from it
end
