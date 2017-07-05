class ChangeLastFourInCreditCard < ActiveRecord::Migration[5.1]
  def change
    change_column :credit_cards, :last_four, :string
  end
end
