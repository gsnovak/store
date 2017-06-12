module Admin
  class PaymentsController < AdminController

    private

    def payment_params
      params.require(:payment).permit(:order, :credit_card, :amount)
    end
  end
end
