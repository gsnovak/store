class OrderItem < ApplicationRecord
  validates :quantity, :source, presence: true
  belongs_to :source, polymorphic: true
end
