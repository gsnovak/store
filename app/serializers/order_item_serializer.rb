class OrderItemSerializer < ActiveModel::Serializer
  include CloudinaryHelper
  attributes :id, :quantity, :source_type, :source_id, :order_id, :source
end
