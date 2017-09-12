class OrderItem < ApplicationRecord
  validates_uniqueness_of :source_type,
    scope: :order_id,
    if: "[Coupon.name].include?(source_type)"
  validates :quantity, :source, presence: true
  belongs_to :source, polymorphic: true
end
