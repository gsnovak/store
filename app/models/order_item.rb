class OrderItem < ApplicationRecord
  validates :quantity, :source, :order, presence: true
  belongs_to :source, polymorphic: true
end
