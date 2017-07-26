class CreditCardSerializer < ActiveModel::Serializer
  attributes :id, :month, :year, :card_number, :first_name, :last_name, :cvv, :last_four
end
