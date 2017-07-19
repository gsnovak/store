class Api::V1::CreditCardsController < Api::V1::BaseController

  wrap_parameters :credit_card, include: CreditCard.column_names + [:number, :user_id]

  def create
    @source_model = CreditCard.new(credit_card_params)
    unless @source_model.save(credit_card_params) && @source_model.errors.empty?
      render status: 400, json: @source_model.errors.full_messages
    end
  end

  def update
   unless @source_model.update(credit_card_params) && @source_model.errors.empty?
      render status: 400, json: @source_model.errors.full_messages
    end
  end

  private

  def credit_card_params
    params.require(:credit_card).permit(:first_name, :last_name, :number, :month, :year, :user_id, :last_four)
  end
end