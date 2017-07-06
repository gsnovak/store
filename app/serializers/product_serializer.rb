class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :quantity, :picture_url

  def quantity
    return 0
  end
end
