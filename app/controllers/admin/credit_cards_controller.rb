module Admin
  class CreditCardsController < AdminController
    before_action :retreive_credit_card_by_id, only: [:create, :edit, :update, :destroy]

    private

    def retreive_credit_card_by_id
      @source_model = CreditCard.find(params[:id])
    end

    def credit_card_params
      params.require(:credit_card).permit(:first_name, :last_name, :month, :year, :token)
    end
  end
end
