class RemoveExpirationDateFromCreditCards < ActiveRecord::Migration[5.1]
  def change
    remove_column :credit_cards, :expiration_date, :datetime
  end
end
