class AddLastFourToCreditCard < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :last_four, :integer
  end
end
