class CreditCard < ApplicationRecord
  include ActiveModel::Validations

  attr_accessor :number
  attr_accessor :cvv
  
  before_save :set_last_four
  validates :number, presence: true, credit_card_number: true
  validates :cvv, :first_name, :last_name, :month, :year, presence: true
  validates :cvv, length: { is: 3 }
  
  belongs_to :user

  private

  def set_last_four
    self.last_four = number[-4..-1] unless number.nil?
  end
end
