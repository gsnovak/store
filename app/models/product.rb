class Product < ApplicationRecord
  self.state_machine({
    active: [:deleted],
    deleted: []
   })

  validates :name, :price, :on_hand_count, presence: true
  has_many :order_items, as: :source
  mount_uploader :picture, PictureUploader
end
