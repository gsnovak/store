class AddTotalToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :total, :integer
  end
end
