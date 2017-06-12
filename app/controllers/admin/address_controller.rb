module Admin
  class AddressController < AdminController
    before_action :retreive_address_by_id, only: [:create, :edit, :update, :destroy]

    private

    def retreive_address_by_id
      @source_model = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:state, :user)
    end
  end
end
