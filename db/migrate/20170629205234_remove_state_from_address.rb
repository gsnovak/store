class RemoveStateFromAddress < ActiveRecord::Migration[5.1]
  def change
    remove_column :addresses, :state, :string
  end
end