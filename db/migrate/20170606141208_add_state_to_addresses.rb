class AddStateToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_reference :addresses, :state, index: true
  end
end
