class CreditCard < ApplicationRecord

  attr_accessor :number

  before_create :set_last_four
  validates :first_name, :last_name, :month, :year, presence: true
  belongs_to :user

  def set_last_four
    self.last_four = number[-4..-1].to_i
  end
end
