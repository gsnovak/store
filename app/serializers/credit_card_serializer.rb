class CreditCardSerializer < ActiveModel::Serializer
  attributes :id, :month, :year, :first_name, :last_name, :cvv, :last_four
end
