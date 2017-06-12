module Admin
  class OrdersController < AdminController
    @@users = User.all

    def index
      @orders = Order.all
    end

    def new
      @order = Order.new
    end

    def create
      @order = Order.new(order_params)

      if @order.save
        redirect_to admin_orders_path
      else
        render 'new'
      end
    end

    def show
      retreive_order_by_id
    end

    def edit
      retreive_order_by_id
    end

    def update
      retreive_order_by_id

      if @order.update(order_params)
        redirect_to admin_orders_path
      else
        render 'edit'
      end
    end

    def destroy
      retreive_order_by_id
      @order.destroy

      redirect_to admin_orders_path
    end

    private
      def retreive_order_by_id
        @order = Order.find(params[:id])
      end

    private
      def order_params
        params.require(:credit_card).permit(:first_name, :last_name, :token, :month, :year)
      end
  end
end
