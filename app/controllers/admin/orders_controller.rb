module Admin
  class OrdersController < AdminController

    def change_state
      @order = Order.find(params[:order_id])

      if @order.make_canceled
        flash[:success] = "Order successfully canceled."
      else
        flash[:error] = @order.errors.full_messages.join(", ")
      end
      @order.save
      redirect_to admin_orders_path
    end

    def edit
      @order = Order.includes(:user, :payment).find(params[:id])
      unless @order.nil?
        @order_items = @order.order_items
        @payment = @order.payment
        @state_changes = StateChange.where(source_type: 'Order', source_id: @order.id)
      end
    end

    private

    def order_params
      params.require(:order).permit(:state)
    end
  end
end
