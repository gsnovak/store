class AddImageIdToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :image_id, :integer
  end
end
