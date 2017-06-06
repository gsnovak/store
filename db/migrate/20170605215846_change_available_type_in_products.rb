class ChangeAvailableTypeInProducts < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :available, :boolean
  end
end
