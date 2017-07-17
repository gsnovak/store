class Api::V1::CreditCardsController < Api::V1::BaseController

  wrap_parameters :credit_card, include: CreditCard.column_names + [:number]

  def update
   if @source_model.update(credit_card_params) && @source_model.errors.empty?
      render status: 200, json: @source_model
    else
      render status: 400, json: @source_model.errors.full_messages
    end
  end

  private

  def credit_card_params
    params.require(:credit_card).permit(:first_name, :last_name, :number, :month, :year, :user_id, :last_four)
  end
end