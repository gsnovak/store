class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_items, :state, :user_id, :products

  has_many :order_items

  def products
    object.order_items.map{ |oi| ProductSerializer.new(oi.source)}
  end
end
