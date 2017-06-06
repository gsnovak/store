class AddTokenToCreditCards < ActiveRecord::Migration[5.1]
  def change
    add_column :credit_cards, :token, :string
  end
end
