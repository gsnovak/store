class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.string :first_name
      t.string :last_name
      t.integer :card_number
      t.datetime :expiration_date
      t.belongs_to :user
      t.timestamps
    end
  end
end
