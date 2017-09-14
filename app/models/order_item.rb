class OrderItem < ApplicationRecord
  validates_uniqueness_of :source_type,
    scope: :order_id,
    if: "source_type == Coupon.name"
  before_save :set_amount
  validates :quantity, :source, presence: true
  belongs_to :source, polymorphic: true

  def set_amount
    -self.amount if source == "Coupon"
  end
end