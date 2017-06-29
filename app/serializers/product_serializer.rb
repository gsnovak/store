class ProductSerializer < ActiveModel::Serializer
  include CloudinaryHelper

  attributes :id, :name, :price, :image_url

  def image_url
    cloudinary_url object.image_id if object.image_id
  end
end
