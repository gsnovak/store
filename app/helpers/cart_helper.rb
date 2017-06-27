module CartHelper
  def get_cart
    unless current_user.nil?
      return current_user.orders.where(state: Order::CART).take || Order.create(user_id: current_user.id)
    end
  end
end