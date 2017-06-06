require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase
  test 'credit card in valid state' do
    credit_card = create(:credit_card)
    assert credit_card.valid?
  end

  test 'credit card invalid without expiration date' do
    credit_card = create(:credit_card)
    credit_card.expiration_date = nil
    refute credit_card.valid?
    assert_not_nil credit_card.errors[:expiration_date]
  end

  test 'credit card invalid without first name' do
    credit_card = create(:credit_card)
    credit_card.first_name = nil
    refute credit_card.valid?
    assert_not_nil credit_card.errors[:first_name]
  end

  test 'credit card invalid without last name' do
    credit_card = create(:credit_card)
    credit_card.last_name = nil
    refute credit_card.valid?
    assert_not_nil credit_card.errors[:last_name]
  end
end
