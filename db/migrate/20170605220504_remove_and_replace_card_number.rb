class RemoveAndReplaceCardNumber < ActiveRecord::Migration[5.1]
  def change
    remove_column :credit_cards, :card_number
  end
end
