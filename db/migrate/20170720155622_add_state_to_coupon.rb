class AddStateToCoupon < ActiveRecord::Migration[5.1]
  def change
    add_column :coupons, :state, :string
  end
end
