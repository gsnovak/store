class  ProductsController < ApplicationController

  def index
    redirect_to new_user_session_path if current_user.nil?
  end

  private

  def product_params
    params.require(:product).permit(:name, :available, :on_hand_count, :price)
  end
end
