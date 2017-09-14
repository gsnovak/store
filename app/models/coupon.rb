class Coupon < ApplicationRecord
  self.state_machine({
    active: [:deleted],
    deleted: []
   })
  validates :amount, :name, :coupon_type, presence: true
  has_many :order_items, as: :source, dependent: :destroy
end
