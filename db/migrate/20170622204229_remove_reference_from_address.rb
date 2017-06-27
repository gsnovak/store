class RemoveReferenceFromAddress < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:addresses, :state, index: true)
  end
end
