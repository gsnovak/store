class OrderMailer < ActionMailer::Base
  default :from => 'graham@wantable.com'

  def send_placement_email(order)
    @order = order
    mail( :to => order.user.email,
    :subject => 'Your order has been placed.' )
  end

  def send_cancellation_email(order)
    @order = order
    mail( to: order.user.email,
    subject: 'Your order has been canceled' )
  end
end