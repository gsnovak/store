class AddCodeToCoupons < ActiveRecord::Migration[5.1]
  def change
    add_column :coupons, :code, :string
  end
end
