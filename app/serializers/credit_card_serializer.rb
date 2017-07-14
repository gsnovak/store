class CreditCardSerializer < ActiveModel::Serializer
  attributes :id, :month, :year, :number, :first_name, :last_name
end
