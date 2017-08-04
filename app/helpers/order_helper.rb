module OrderHelper
  def get_cart
    unless !user_signed_in?
      Order.find_or_create_by(state: Order::CART, user_id: current_user.id)
    end
  end

  def get_placed_order
    unless !user_signed_in?
      current_user.orders.where(state: Order::PLACED).order(id: :desc).take
    end
  end
end
