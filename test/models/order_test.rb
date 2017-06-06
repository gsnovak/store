require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'test valid order' do
    order = create(:order)
    assert order.valid?
  end

  test 'order invalid without state' do
    order = create(:order)
    order.state = nil
    refute order.valid?
    assert_not_nil order.errors[:state]
  end

end
