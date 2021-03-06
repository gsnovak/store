class Payment < ApplicationRecord
  self.state_machine({
    pending: [:completed],
    completed: [:voided],
    voided: []
  })

  validates :amount, presence: true
  belongs_to :credit_card
  belongs_to :order,
              inverse_of: :payment
end
