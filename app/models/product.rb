class Product < ApplicationRecord
  validates :name, :price, :on_hand_count, presence: true
  has_many :order_items, as: :source
end
