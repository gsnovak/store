class RemoveZipCodeFromAddress < ActiveRecord::Migration[5.1]
  def change
    remove_column :addresses, :zip_code
  end
end
