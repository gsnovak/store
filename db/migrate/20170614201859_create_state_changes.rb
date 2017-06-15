class CreateStateChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :state_changes do |t|
      t.string :previous_state
      t.string :next_state
      t.references :source, polymorphic: true

      t.timestamps
    end
  end
end
