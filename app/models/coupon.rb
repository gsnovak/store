class Coupon < ApplicationRecord
  validates :amount, :name, presence: true
  has_many :order_items, as: :source, dependent: :destroy
end
