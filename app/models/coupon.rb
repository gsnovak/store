class Coupon < ApplicationRecord
  self.state_machine({
    active: [:deleted],
    deleted: []
   })
  
  validates :amount, :name, presence: true
  has_many :order_items, as: :source, dependent: :destroy
end
