module Admin
  class CreditCardsController < AdminController
    def index
      @credit_cards = CreditCard.all
    end

    def new
      @credit_card = CreditCard.new
    end

    def create
      @credit_card = CreditCard.new(credit_card_params)

      if @credit_card.save
        redirect_to admin_credit_cards_path
      else
        render 'new'
      end
    end

    def show
      retreive_credit_card_by_id
    end

    def edit
      retreive_credit_card_by_id
    end

    def update
      retreive_credit_card_by_id

      if @credit_card.update(credit_card_params)
        redirect_to @credit_card
      else
        render 'edit'
      end
    end

    def destroy
      retreive_credit_card_by_id
      @credit_card.destroy

      redirect_to admin_credit_cards_path
    end

    private
      def retreive_credit_card_by_id
        @credit_card = CreditCard.find(params[:id])
      end

    private
      def credit_card_params
        params.require(:credit_card).permit(:first_name, :last_name, :month, :year, :token)
      end
  end
end
