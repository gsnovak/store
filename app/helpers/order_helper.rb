module OrderHelper
  def get_cart
    unless current_user.nil?
      Order.find_or_create_by(state: Order::CART, user_id: current_user.id)
    end
  end

  def get_placed_order
    unless current_user.nil?
      return current_user.orders.where(state: Order::PLACED).order(id: :desc).take
    end
  end
end
