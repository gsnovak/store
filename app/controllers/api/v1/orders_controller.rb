class Api::V1::OrdersController < Api::V1::BaseController
  include OrderHelper
  def index
    @order = Order.find_or_initialize_by(user_id: current_user.id)
    render json: @order
  end

  def cart
    render json: get_cart
  end

  def get_placed
    render json: get_placed_order
  end

  def change_state
    @order = Order.find(params[:id])

    if @order.make_placed
      render status: 200, json: @order
    else
      render status: 400, json: @order.errors.full_messages
    end
  end

  private

  def order_params
    params.require(:order).permit(:id, :state, :user_id, :order_items)
  end
end
