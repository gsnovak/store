class Api::V1::OrderItemsController < Api::V1::BaseController

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :source_id, :source_type, :order_id)
  end
end