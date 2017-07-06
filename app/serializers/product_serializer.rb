class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :image_url, :quantity, :picture_url

  def quantity
    return 0
  end
end
