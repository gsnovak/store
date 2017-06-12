module Admin
  class CouponsController < AdminController
    def index
      @coupons = Coupon.all
    end

    def new
      @coupon = Coupon.new
    end

    def create
      @coupon = Coupon.new(coupon_params)

      if @coupon.save
        redirect_to admin_coupons_path
      else
        render 'new'
      end
    end

    def show
      retreive_coupon_by_id
    end

    def edit
      retreive_coupon_by_id
    end

    def update
      retreive_coupon_by_id

      if @coupon.update(coupon_params)
        redirect_to admin_coupons_path
      else
        render 'edit'
      end
    end

    def destroy
      retreive_coupon_by_id
      @coupon.destroy

      redirect_to admin_coupons_path
    end

    private
      def retreive_coupon_by_id
        @coupon = Coupon.find(params[:id])
      end

    private
      def coupon_params
        params.require(:coupon).permit(:code, :name, :amount)
      end
  end
end
