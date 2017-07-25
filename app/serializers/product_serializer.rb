class ProductSerializer < ActiveModel::Serializer
  include Cloudinary
  attributes :id, :name, :price, :quantity, :picture_url, :on_hand_count, :available

  def quantity
    return 0
  end

  def picture_url
    object.picture_url(:standard)
  end
end
