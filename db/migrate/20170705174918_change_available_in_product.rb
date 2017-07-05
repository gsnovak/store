class ChangeAvailableInProduct < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :available
    add_column :products, :available, :boolean
  end
end
