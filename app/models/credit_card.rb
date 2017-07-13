class CreditCard < ApplicationRecord
  #this needs to be fixed before_save :set_last_four

  attr_accessor :number

  validates :first_name, :last_name, :month, :year, presence: true
  belongs_to :user

  private

  def set_last_four
    self.last_four = number[-4..-1]
  end
end
