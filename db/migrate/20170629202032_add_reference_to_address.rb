class AddReferenceToAddress < ActiveRecord::Migration[5.1]
  def change
    add_reference :addresses, :state, foreign_key: true
  end
end
