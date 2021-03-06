class ProductsController < ApplicationController

  private

  def product_params
    params.require(:product).permit(:name, :available, :on_hand_count, :amount)
  end
end
