class Coupon < ApplicationRecord
  self.state_machine({
    active: [:deleted],
    deleted: []
   })
  before_save :negate_amount
  validates :amount, :name, :coupon_type, presence: true
  has_many :order_items, as: :source, dependent: :destroy

  def negate_amount
    self.amount *= -1
  end
end
