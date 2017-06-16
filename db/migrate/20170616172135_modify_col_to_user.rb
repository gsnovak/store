class ModifyColToUser < ActiveRecord::Migration[5.1]
  def change
    change_table(:users) do |t|
      t.change :first_name, :string
      t.change :last_name, :string
      t.change :user_name, :string, unique: true
    end
  end
end
