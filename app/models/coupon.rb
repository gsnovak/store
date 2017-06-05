class Coupon < ApplicationRecord
  validates :amount, :name, presence: true
  belongs_to :source, polymorphic: true
end
