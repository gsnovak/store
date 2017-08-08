module Admin
  class ProductsController < AdminController
    include ItemUtilityHelper

    private

    def product_params
      params.require(:product).permit(:name, :available, :on_hand_count, :price, :picture)
    end
  end
end
