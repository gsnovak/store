class Api::V1::OrdersController < Api::V1::BaseController
  include CartHelper
  def index
    @order = Order.find_or_initialize_by(user_id: current_user.id)
    render json: @order
  end

  def cart
    render json: get_cart
  end

  private

  def order_params
    params.require(:order).permit(:id, :state, :user_id, :order_items)
  end
end
