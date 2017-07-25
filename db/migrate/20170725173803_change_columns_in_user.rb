class ChangeColumnsInUser < ActiveRecord::Migration[5.1]
  def change
    change_column :user, :first_name, :string
    change_column :user, :last_name, :string
  end
end
