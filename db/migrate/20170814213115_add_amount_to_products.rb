class AddAmountToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :amount, :float
  end
end
