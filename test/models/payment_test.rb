require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  test 'test valid payment' do
    payment = create(:payment)
    assert payment.valid?
  end

  test 'payment invalid without amount' do
    payment = create(:payment)
    payment.amount = nil
    refute payment.valid?
    assert_not_nil payment.errors[:amount]
  end
end
