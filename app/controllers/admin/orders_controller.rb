module Admin
  class OrdersController < AdminController

    private
    
    def order_params
      params.require(:credit_card).permit(:first_name, :last_name, :token, :month, :year)
    end
  end
end
