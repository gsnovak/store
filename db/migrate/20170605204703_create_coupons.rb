class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.float :amount 
      t.string :name
      t.references :source, polymorphic: true, index: true

      t.timestamps
    end
  end
end
