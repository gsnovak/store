require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'test valid order' do
    order = create(:order)
    assert order.valid?
  end

  test 'order invalid without state' do
    #todo test valid state
  end

end
