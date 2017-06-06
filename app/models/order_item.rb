class OrderItem < ApplicationRecord
  belongs_to :source, polymorphic: true
end
