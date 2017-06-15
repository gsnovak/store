module Admin
  class OrdersController < AdminController

    def change_state
      @order = Order.find(params[:order_id])

      unless @order.make_canceled
        flash[:error] = "Order cannot be canceled."
      end
      @order.save
      redirect_to admin_orders_path
    end

    private

    def order_params
      params.require(:order).permit(:state)
    end
  end
end
