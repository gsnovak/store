class  CheckoutController < ApplicationController
  before_action :is_signed_in?

  def index
      redirect_to new_user_session_path if current_user.nil?
      @address = current_user.address || Address.new(user_id: current_user.id)
      @credit_card = current_user.credit_card || CreditCard.new(user_id: current_user.id)
      @states = State.all
  end

  def thank_you
    @address = current_user.address || Address.new(user_id: current_user.id)
    @credit_card = current_user.credit_card || CreditCard.new(user_id: current_user.id)
    render 'checkout/thank_you'
  end

  private

  def is_signed_in?
    redirect_to new_user_session_path if !user_signed_in?
  end
end
