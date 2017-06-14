module Admin
  class OrdersController < AdminController

    private

    def order_params
      params.require(:order).permit(:state)
    end
  end
end
