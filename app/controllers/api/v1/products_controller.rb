class  Api::V1::ProductsController < ApplicationController
  def index
    @products = Product.all
    puts @products.to_json

    render json: @products.to_json
  end

  private

  def credit_card_params
    params.require(:product).permit(:name, :available, :on_hand_count, :price, )
  end
end
