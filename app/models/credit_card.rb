class CreditCard < ApplicationRecord
  include ActiveModel::Validations

  attr_accessor :number
  attr_accessor :cvv

  before_save :set_last_four
  validates :number, presence: true, credit_card_number: true
  validates :cvv, :first_name, :last_name, :month, :year, presence: true
  validates :cvv, length: { is: 3 }
  validate :expiry_cannot_be_in_the_past

  belongs_to :user

  def expired?
    expired_by?(Time.zone.now.to_date)
  end

  def expired_by?(date)
    expiration_date < date
  end

  def expiration_date
    DateTime.parse("#{self.year}-#{self.month}-01").end_of_month
  end

  def expiry_cannot_be_in_the_past
    if expired?
      errors[:base] << "Card is expired."
      false
    end
    true
  end

  private

  def set_last_four
    self.last_four = number[-4..-1] unless number.nil?
  end
end
