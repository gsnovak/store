class AddCcLastFourToCreditCard < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :cc_last_four, :integer
  end
end
