class AddStateToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :state, :string
  end
end
