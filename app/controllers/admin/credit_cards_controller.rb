module Admin
  class CreditCardsController < AdminController

    private

    def credit_card_params
      params.require(:credit_card).permit(:first_name, :last_name, :month, :year, :token)
    end
  end
end
