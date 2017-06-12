module Admin
  class ProductsController < AdminController
    before_action :retreive_product_by_id, only: [:create, :edit, :update, :destroy]
    
    private

    def retreive_product_by_id
      @source_model = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :available, :on_hand_count, :price)
    end
  end
end
