class ChangeImageIdInProducts < ActiveRecord::Migration[5.1]
  def change
    change_table :products do |t|
      t.change :image_id, :string
    end
  end
end
