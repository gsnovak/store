module OrderHelper
  def get_cart
    unless current_user.nil?
      return current_user.orders.where(state: Order::CART).take || Order.create(user_id: current_user.id)
    end
  end

  def get_placed_order
    unless current_user.nil?
      return current_user.orders.where(state: Order::PLACED).take
    end
  end
end
