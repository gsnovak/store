class AddStateToPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :state, :string
  end
end
