class AddStreetAddr2ToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :street_addr_2, :string
  end
end
