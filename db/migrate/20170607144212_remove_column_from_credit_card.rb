class RemoveColumnFromCreditCard < ActiveRecord::Migration[5.1]
  def change
    remove_column :credit_cards, :experation_date, :datetime
  end
end
