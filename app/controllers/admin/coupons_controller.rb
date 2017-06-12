module Admin
  class CouponsController < AdminController

    private

    def coupon_params
      params.require(:coupon).permit(:code, :name, :amount)
    end
  end
end
