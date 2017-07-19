class CreditCard < ApplicationRecord
  attr_accessor :number
  include ActiveModel::Validations
  validates :number, presence: true, credit_card_number: true

  before_save :set_last_four

  validates :first_name, :last_name, :month, :year, presence: true

  belongs_to :user

  private

  def set_last_four
    self.last_four = number[-4..-1] unless number.nil?
  end
end
