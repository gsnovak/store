class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :state
      t.belongs_to :user, index: true 
      t.timestamps
    end
  end
end
