module OrderHelper
  def get_cart
    unless !user_signed_in?
      Order.find_or_create_by(state: Order::CART, user_id: current_user.id)
    end
  end
end
