require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'transition from cart to placed' do
    order = create(:order)
    product = create(:product)
    cc = create(:credit_card, user_id: order.user.id)
    order.save

    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 10)

    assert order.make_placed
  end

 test 'can transition from placed to canceled' do
    order = create(:order)
    product = create(:product)
    cc = create(:credit_card, user_id: order.user.id)
    order.save

    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 10)

    assert order.make_placed!
    assert_equal order.state.to_sym, Order::PLACED, order.errors.full_messages
    order.reload
    assert order.make_canceled, order.errors.messages
  end

  test 'cannot transition from cart to canceled' do
    order = create(:order)
    product = create(:product)
    cc = create(:credit_card, user_id: order.user.id)
    order.save
    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 10)

    assert_not order.make_canceled
  end

  test 'cannot place an empty order' do
    order = create(:order)
    product = create(:product)
    cc = create(:credit_card, user_id: order.user.id)
    order.save

    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 0)

    assert_not order.make_placed
  end

  test 'not enough inventory' do
    order = create(:order)
    product = create(:product)
    cc = create(:credit_card, user_id: order.user.id)
    order.save

    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 15)

    assert_not order.make_placed
  end

  test 'properly removes inventory' do
    order = create(:order)
    product = create(:product)
    cc = create(:credit_card, user_id: order.user.id)
    order.save

    started_with = product.on_hand_count
    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 5)

    order.make_placed
    product.reload
    assert_equal(started_with-order_item.quantity, product.on_hand_count, "Properly removed #{order_item.quantity} items from product.")
  end

  test 'payment is properly processed on placed' do
    order = create(:order)
    product = create(:product)
    cc = create(:credit_card, user_id: order.user.id)
    order.save

    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 7)

    order.make_placed
    assert_equal(Payment::COMPLETED, order.payment.state.to_sym)
  end

  test 'payment is properly voided on cancel' do
    order = create(:order)
    product = create(:product)
    cc = create(:credit_card, user_id: order.user.id)
    order.save

    order_item = OrderItem.create(order_id: order.id, source_type: Product.name, source_id: product.id, quantity: 7)

    assert order.make_placed!
    assert_equal order.state.to_sym, Order::PLACED, order.errors.full_messages

    order.reload
    assert order.make_canceled!
    assert_equal(Payment::VOIDED, order.payment.state.to_sym)
  end
end