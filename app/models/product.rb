class Product < ApplicationRecord
  validates :name, :available, :price
  belongs_to :source, polymorphic: true
end
