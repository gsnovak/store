class OrderItemSerializer < ActiveModel::Serializer
  include CloudinaryHelper
  attributes :id, :quantity, :source_type, :source_id, :order_id, :source, :image_url

  def image_url
    cloudinary_url object.source.image_id if object.source.image_id if object.source.is_a? Product
  end
end
