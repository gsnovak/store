class AddSourceReferenceToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :source, polymorphic: true
  end
end
