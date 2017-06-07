class Order < ApplicationRecord
  self.state_machine({
    cart: [:placed, :canceled],
    placed: [:canceled],
    canceled: []
  })

  validates :state, presence: true
  belongs_to :user
  has_many :order_items, as: :source
  #todo implement state transition logic
end
