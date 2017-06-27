class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :image_id
end
