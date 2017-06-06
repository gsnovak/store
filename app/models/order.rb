class Order < ApplicationRecord
  validates :state, presence: true 
  belongs_to :user
  has_many :order_items, as: :source
end
