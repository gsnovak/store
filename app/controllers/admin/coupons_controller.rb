module Admin
  class CouponsController < AdminController

    def index
      @source_models = Coupon.where(state: Coupon::ACTIVE)
    end

    def destroy
      @source_model.make_deleted!
      redirect_to sources_path
    end

    private

    def coupon_params
      params.require(:coupon).permit(:code, :name, :amount)
    end
  end
end
