class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.belongs_to :order
      t.belongs_to :credit_card
      t.float :amount
      t.timestamps
    end
  end
end
