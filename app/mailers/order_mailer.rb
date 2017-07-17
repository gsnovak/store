class OrderMailer < ActionMailer::Base
  default from: 'it+dev@wantable.com'

  def send_placement_email(order_id)
    @order = Order.find order_id
    puts "in send_placement_email"
    #@order.user.email
    mail( to: 'graham@wantable.com', subject: 'Your order has been placed.' )
  end

  def send_cancellation_email(order_id)
    @order = Order.find order_id
    mail( to: @order.user.email, subject: 'Your order has been canceled' )
  end
end