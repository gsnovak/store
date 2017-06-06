class Payment < ApplicationRecord
  validates :amount, :amount, presence: true
  belongs_to :credit_card
end
