class  CheckoutController < ApplicationController
  authorize_resource class: false
  before_action :authenticate_user!
  def index
    @address = current_user.address || Address.new(user_id: current_user.id)
    @credit_card = current_user.credit_card || CreditCard.new(user_id: current_user.id)
    @states = State.all
  end

  def thank_you
    @address = current_user.address || Address.new(user_id: current_user.id)
    @credit_card = current_user.credit_card || CreditCard.new(user_id: current_user.id)
  end
end
