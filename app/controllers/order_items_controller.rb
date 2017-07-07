class  OrderItemsController < ApplicationController

  private

  def order_params
    params.require(:order_item).permit(:quantity, :source_id, :source_type, :order_id)
  end
end
