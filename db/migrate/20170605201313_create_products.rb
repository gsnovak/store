class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :available
      t.integer :on_hand_count
      t.float :price
      t.references :source, polymorphic: true, index: true
      t.timestamps
    end
  end
end
