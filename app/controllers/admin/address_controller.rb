module Admin
  class AddressController < AdminController
    def index
      @addresses = Address.all
    end

    def new
      @address = Address.new
    end

    def create
      @address = Address.new(address_params)

      if @address.save
        redirect_to @address
      else
        render 'new'
      end
    end

    def show
      retreive_address_by_id
    end

    def edit
      retreive_address_by_id
    end

    def update
      retreive_address_by_id

      if @address.update(address_params)
        redirect_to @address
      else
        render 'edit'
      end
    end

    def destroy
      retreive_address_by_id
      @address.destroy

      redirect_to address_index_path
    end

    private
      def retreive_address_by_id
        @address = Address.find(params[:id])
      end

    private
      def address_params
        params.require(:address).permit(:state, :user)
      end
  end
end
