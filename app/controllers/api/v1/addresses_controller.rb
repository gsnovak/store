class Api::V1::AddressesController < Api::V1::BaseController

  private

  def address_params
    params.require(:address).permit(:street_addr, :state_id, :state, :city, :zip_code, :user_id)
  end
end