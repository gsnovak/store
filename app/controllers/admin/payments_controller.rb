module Admin
  class PaymentsController < AdminController
    def index
      @payments = Payment.all
    end

    def new
      @payment = Payment.new
    end

    def create
      @payment = Payment.new(payment_params)

      if @payment.save
        redirect_to admin_products_path
      else
        render 'new'
      end
    end

    def show
      retreive_payment_by_id
    end

    def edit
      retreive_payment_by_id
    end

    def update
      retreive_payment_by_id

      if @payment.update(payment_params)
        redirect_to admin_products_path
      else
        render 'edit'
      end
    end

    def destroy
      retreive_payment_by_id
      @payment.destroy

      redirect_to admin_products_path
    end

    private
      def retreive_payment_by_id
        @payment = Payment.find(params[:id])
      end

    private
      def payment_params
        params.require(:payment).permit(:state, :user)
      end
  end
end
