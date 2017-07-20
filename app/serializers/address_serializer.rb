class AddressSerializer < ActiveModel::Serializer
  attributes :street_addr, :state_id, :state, :city, :zip_code, :user_id
end
