class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :source_type, :source_id, :order_id
end
