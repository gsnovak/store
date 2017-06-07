class Payment < ApplicationRecord
  validates :amount, presence: true
  belongs_to :credit_card
end
