class Payment < ApplicationRecord
  validates :amount, presence: true
  belongs_to :credit_card
  before_destroy :valid_state?

  self.state_machine({
    pending: [:completed],
    completed: [:voided],
    voided: []
  })

  def in_valid_state
    is_pending
  end
end
