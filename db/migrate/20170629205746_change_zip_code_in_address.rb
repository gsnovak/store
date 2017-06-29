class ChangeZipCodeInAddress < ActiveRecord::Migration[5.1]
  def change
    change_column :addresses, :zip_code, :string
  end
end
