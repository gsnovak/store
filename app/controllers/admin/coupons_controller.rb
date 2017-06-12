module Admin
  class CouponsController < AdminController
    before_action :retreive_coupon_by_id, only: [:create, :edit, :update, :destroy]

    private

    def retreive_coupon_by_id
      @source_model = Coupon.find(params[:id])
    end


    def coupon_params
      params.require(:coupon).permit(:code, :name, :amount)
    end
  end
end
