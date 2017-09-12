class Api::V1::CouponsController < Api::V1::BaseController

  def index
    @coupon = Coupon.find_by(code: params[:code])

    render json: @coupon
  end

  private

  def coupon_params
    params.require(:order).permit(:id, :code, :amount)
  end
end
