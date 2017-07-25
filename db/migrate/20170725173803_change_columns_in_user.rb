class ChangeColumnsInUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :first_name, :string
    change_column :users, :last_name, :string
  end
end
