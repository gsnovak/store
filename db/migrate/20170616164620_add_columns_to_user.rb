class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    change_table(:users) do |t|
    t.column :first_name, :integer
    t.column :last_name, :integer
    t.column :user_name, :integer, unique: true
    # Other column alterations here
    end
  end
end


