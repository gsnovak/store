module Admin
  class ProductsController < AdminController
    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to admin_products_path
      else
        render 'new'
      end
    end

    def show
      retreive_product_by_id
    end

    def edit
      retreive_product_by_id
    end

    def update
      retreive_product_by_id

      if @product.update(product_params)
        redirect_to admin_products_path
      else
        render 'edit'
      end
    end

    def destroy
      retreive_product_by_id
      @product.destroy

      redirect_to admin_products_path
    end

    private
      def retreive_product_by_id
        @product = Product.find(params[:id])
      end

    private
      def product_params
        params.require(:product).permit(:name, :available, :on_hand_count, :price)
      end
  end
end
