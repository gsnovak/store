module Admin
  class CouponsController < AdminController
    include ItemUtilityHelper

    private

    def coupon_params
      params.require(:coupon).permit(:code, :name, :amount, :coupon_type)
    end
  end
end
