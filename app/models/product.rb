class Product < ApplicationRecord
  self.state_machine({
    active: [:deleted],
    deleted: []
   })
  validates :amount, numericality: { greater_than: 0 }
  validates :name, :amount, :on_hand_count, presence: true
  validates :on_hand_count, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  has_many :order_items, as: :source
  mount_uploader :picture, PictureUploader
end
