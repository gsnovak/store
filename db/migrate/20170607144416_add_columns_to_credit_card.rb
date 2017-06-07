class AddColumnsToCreditCard < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :month, :integer
    add_column :credit_cards, :year, :integer
  end
end
