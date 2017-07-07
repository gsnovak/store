class OrderItem < ApplicationRecord
  validates :quantity, presence: true
  belongs_to :source, polymorphic: true
end
