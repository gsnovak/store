class  Api::V1::ProductsController < Api::V1::BaseController

  def index
    @products = Product.active

    render json: @products
  end

  private

  def product_params
    params.require(:product).permit(:name, :available, :on_hand_count, :price )
  end
end
