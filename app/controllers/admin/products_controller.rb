module Admin
  class ProductsController < AdminController
    include ItemUtilityHelper

    private

    def product_params
      params.require(:product).permit(:name, :available, :on_hand_count, :picture, :amount)
    end
  end
end
