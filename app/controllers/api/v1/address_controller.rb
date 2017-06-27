class Api::V1::AddressController < Api::V1::BaseController

  private

  def address_params
    params.require(:address).permit(:street_addr, :state, :city, :zip_code, :user_id)
  end
end
