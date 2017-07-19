class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :quantity, :picture_url, :on_hand_count

  def quantity
    return 0
  end
end
