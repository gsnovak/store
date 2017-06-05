class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street_addr
      t.string :state
      t.string :city
      t.integer :zip_code
      t.belongs_to :user

      t.timestamps
    end
  end
end
