class AddNameToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :name, :string
  end
end
