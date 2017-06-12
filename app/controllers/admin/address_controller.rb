module Admin
  class AddressController < AdminController

    private
    
    def address_params
      params.require(:address).permit(:state, :user)
    end
  end
end
