class OrderItemSerializer < ActiveModel::Serializer
  include CloudinaryHelper
  attributes :id, :quantity, :source_type, :source_id, :order_id, :source

  def item_total
    if object.is_a? Product
      return object.quantity * object.source.price
    end
  end
end
