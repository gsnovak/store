class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_items, :state, :user_id

  has_many :order_items
end
