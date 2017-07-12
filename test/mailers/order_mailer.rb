require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "placement" do
    order = create(:order)
    email = OrderMailer.send_placement_email(order)
    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['me@example.com'], email.from
    assert_equal ['friend@example.com'], email.to
    assert_equal 'Your order has been placed.', email.subject
  end

  test "cancelation" do
    order = create(:order)
    email = OrderMailer.send_cancellation_email(order)
    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['graham@wantable.com'], email.from
    assert_equal [order.user.email], email.to
    assert_equal 'Your order has been canceled.', email.subject
  end
end