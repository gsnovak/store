class Product < ApplicationRecord
  self.state_machine({
    active: [:deleted],
    deleted: []
   })
  validate :on_hand_count, :in_range
  validates :price, numericality: { greater_than: 0 }
  validates :name, :price, :on_hand_count, presence: true

  has_many :order_items, as: :source
  mount_uploader :picture, PictureUploader

  def in_range
    if self.on_hand_count < 0
      errors[:base] << "On hand count must be greater than or equal to 0"
    elsif self.on_hand_count > 100
      errors[:base] << "On hand count must less than or equal to 100"
    end
  end
end
