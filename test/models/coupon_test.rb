require 'test_helper'

class CouponTest < ActiveSupport::TestCase
  test 'coupon in valid state' do
    coupon = create(:coupon)
    assert coupon.valid?
  end

  test 'coupon invalid without amount' do
    coupon = create(:coupon)
    coupon.amount = nil
    refute coupon.valid?
    assert_not_nil coupon.errors[:amount]
  end

  test 'coupon invalid without name' do
    coupon = create(:coupon)
    coupon.name = nil
    refute coupon.valid?
    assert_not_nil coupon.errors[:name]
  end
end
