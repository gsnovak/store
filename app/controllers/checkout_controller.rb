class  CheckoutController < ApplicationController
  def index
    @address = current_user.address || Address.new(user_id: current_user.id)
    @credit_card = current_user.credit_card || CreditCard.new(first_name: current_user.first_name, last_name: current_user.last_name, user_id: current_user.id)
  end
end
