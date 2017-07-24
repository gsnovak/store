class Api::V1::CreditCardsController < Api::V1::BaseController

  wrap_parameters :credit_card, include: CreditCard.column_names + [:card_number, :cvv, :user_id]

  private

  def credit_card_params
    params.require(:credit_card).permit(:first_name, :last_name, :card_number, :month, :year, :user_id, :last_four, :cvv)
  end
end