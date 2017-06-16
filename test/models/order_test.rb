require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'transition from cart to placed' do
    order = create(:order)
    product = create(:product)

    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 10)
    order.add_order_item(order_item)

    assert order.make_placed
  end

  test 'cannot transition from cart to canceled' do
    order = create(:order)
    product = create(:product)

    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 10)
    order.add_order_item(order_item)

    assert_not order.make_canceled
  end

  test 'cannot place an empty order' do
    order = create(:order)
    product = create(:product)

    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 0)
    order.add_order_item(order_item)

    assert_not order.make_placed
  end
end
