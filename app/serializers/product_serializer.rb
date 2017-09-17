class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :quantity, :picture_url, :on_hand_count, :available

  def quantity
    return 0
  end

  def picture_url
    object.picture_url(:standard)
  end
end
