class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street_addr, :street_addr_2, :state_id, :state, :city, :zip_code, :user_id, :name
end
