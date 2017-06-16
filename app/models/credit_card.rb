class CreditCard < ApplicationRecord

  attr_accessor :cc_number
  before_create :set_last_four_dig

  validates :first_name, :last_name, :token, :month, :year, presence: true
  belongs_to :user

  def set_last_four_dig
    cc_last_four = cc_number[-4..-1]
  end
end
