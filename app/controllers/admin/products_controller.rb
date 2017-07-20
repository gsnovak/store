module Admin
  class ProductsController < AdminController

    def index
      @source_models = Product.where(state: Product::ACTIVE)
    end

    def destroy
      @source_model.make_deleted!
      redirect_to sources_path
    end

    private

    def product_params
      params.require(:product).permit(:name, :available, :on_hand_count, :price, :picture)
    end
  end
end
