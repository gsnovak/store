class ChangeMonthAndYearInCreditCard < ActiveRecord::Migration[5.1]
  def change
    change_table :credit_cards do |t|
      t.change :month, :string
      t.change :year, :string
    end
  end
end
