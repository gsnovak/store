module Admin
  class PaymentsController < AdminController
    before_action :retreive_payment_by_id, only: [:create, :edit, :update, :destroy]

    private

    def retreive_payment_by_id
      @source_model = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:order, :credit_card, :amount)
    end
  end
end
