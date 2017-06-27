class Api::V1::CreditCardsController < Api::V1::BaseController

  private

  def credit_card_params
    params.require(:credit_card).permit(:first_name, :last_name, :number, :month, :year, :last_four)
  end
end



