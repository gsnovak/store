class RemoveImageColumnsFromProducts < ActiveRecord::Migration[5.1]
  def change
    change_table(:products) do |t|
      t.remove :image_id
      t.remove :image_url
    end
  end
end
