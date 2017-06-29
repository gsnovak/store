class  Api::V1::ProductsController < ApplicationController
  def index
    @products = Product.all

    render json: @products
  end

  private

  def product_params
    params.require(:product).permit(:name, :available, :on_hand_count, :price )
  end
end
