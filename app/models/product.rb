class Product < ApplicationRecord
  validates :name, :available, :price
  has_many :order_items, as: :source
end
