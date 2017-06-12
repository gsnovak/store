module Admin
  class OrdersController < AdminController
    before_action :retreive_order_by_id, only: [:create, :edit, :update, :destroy]

    private

    def retreive_order_by_id
      @source_model = Order.find(params[:id])
    end

    def order_params
      params.require(:credit_card).permit(:first_name, :last_name, :token, :month, :year)
    end
  end
end
