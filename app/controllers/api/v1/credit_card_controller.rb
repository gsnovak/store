class Api::V1::CreditCardController < Api::V1::BaseController

  private

  def credit_card_params
    params.require(:credit_card).permit(:first_name, :last_name, :number, :month, :year, :user_id)
  end
end